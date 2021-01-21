import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillybrowser/models/user.dart';
import "./subscreens/login.dart";
import 'dart:math';
import 'package:rflutter_alert/rflutter_alert.dart';
import "../services/conferenceservice.dart";
class Conference extends StatefulWidget {
  @override
  _ConferenceState createState() => _ConferenceState();
}

class _ConferenceState extends State<Conference> {
  bool auth = false;
  User user;
  Widget drawer;
  TextEditingController controller=TextEditingController();
    TextEditingController name=TextEditingController();

  void checkAuth() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('info')) {
      auth = true;
      user = User(
          name: pref.getStringList('info')[0],
          number: pref.getStringList('info')[1],
          docid: pref.getStringList('info')[2]);
      setState(() {});
    } else
      setState(() {});
  }

  void initState() {
    super.initState();
 checkAuth();

   
  }

  @override
  Widget build(BuildContext context) {
    if(!auth)
    return Login(next:(number,docid) async{
       
      this.setState(() {
        this.auth=true;
        checkAuth();
       
      });
    });
    else
    return Scaffold(
      drawer: Drawer(
        
      child: ListView(children: [
        auth
            ? UserAccountsDrawerHeader(
              decoration:BoxDecoration(color: CupertinoColors.systemPurple),
                accountName: Text(user.name??'No Name'), accountEmail: Text(user.number))
            : DrawerHeader(child: Text("Plz login")),
        auth
            ? ListTile(
                leading: Icon(Icons.history),
                title: Text("History"),
                subtitle: Text("View Meeting Histories"),
                onTap: (){
                  Navigator.pushNamed(context,"/MeetingHistory");
                },
              )
            : null,
        auth
            ? ListTile(
                leading: Icon(Icons.settings),
                title: Text("settings"),
                subtitle: Text('View settings'),
                onTap: (){
                  Navigator.pushNamed(context, "/MeetingSettings");
                },
              )
            : null,
        auth?ListTile(leading: Icon(Icons.logout),title:Text("Logout"),subtitle: Text("Logout here"),onTap: () async {
   SharedPreferences pref = await SharedPreferences.getInstance();
   await pref.remove('info');
   setState(() {
     this.auth=false;
   });
        },):null,
      ]),
    ),
      backgroundColor: Color(0xffE9CFEC),
      appBar: AppBar(
        backgroundColor: CupertinoColors.systemPurple,
        title: ListTile(
          leading: Hero(
              child: Icon(
                Icons.meeting_room,
                color: Colors.white,
              ),
              tag: "Conf"),
          title: Text(
            "Skilly Meet",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 140,
          ),
          RaisedButton.icon(
            elevation: 50,
            icon: Icon(
              Icons.meeting_room,
              color: Colors.white,
            ),
            label: Text(
              "Host A Meeting",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            onPressed: () {
              showDialog(context: context,builder: (context){
                return AlertDialog(actions: [
                  FlatButton.icon(onPressed: () async {
                     SharedPreferences pref = await SharedPreferences.getInstance();
                     var info =  pref.getStringList("info");
                     Navigator.pop(context);
              ConferenceService(name:info[0],number: info[1],docid: info[2],roomid:Random().nextInt(10000).toString()).hostMeeting();
                  }, icon: Icon(Icons.arrow_right), label: Text("Next"))
                ],title:Text("Host A Meeting"),content: Container(child:
                  TextField(controller: this.name,decoration: InputDecoration(labelText: " Name (Optional)",border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),))
              );
              });
            },
            color: CupertinoColors.systemPurple,
          ),
          Theme(
              data: ThemeData(
                primaryColor: CupertinoColors.systemPurple,
                primaryColorDark: Colors.red,
              ),
              child: Container(
                  margin:
                      EdgeInsets.only(top: 50, left: 50, right: 50, bottom: 10),
                  child: TextField(
                    controller: this.controller,
                    keyboardType:TextInputType.number,
                    keyboardAppearance: Brightness.dark,
                    decoration: InputDecoration(
                      
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: CupertinoColors.systemPurple),
                            borderRadius: BorderRadius.circular(5)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: CupertinoColors.systemPurple),
                            borderRadius: BorderRadius.circular(5)),
                        prefixIcon: Icon(
                          Icons.supervised_user_circle,
                          color: CupertinoColors.systemPurple,
                        ),
                        labelText: "Join A Meeting",
                        labelStyle:
                            TextStyle(color: CupertinoColors.systemPurple)),
                  ))),
          FlatButton.icon(
              icon: Icon(
                Icons.merge_type_outlined,
                color: CupertinoColors.systemPurple,
              ),
              onPressed: () async {
                 SharedPreferences pref = await SharedPreferences.getInstance();
                     var info =  pref.getStringList("info");
                  
              if(!await ConferenceService(name:this.name??info[0],number: info[1],docid: info[2],roomid:this.controller.text).hostMeeting('join'))
                   Alert(
                  context: context,
                  title: 'ROOM NOT FOUND',
                  type: AlertType.error)
              .show();
              else
                 Navigator.pop(context);
              },
              label: Text("Join",
                  style: TextStyle(color: CupertinoColors.systemPurple)))
        ],
      )),
    );
  }
}
