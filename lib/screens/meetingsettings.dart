import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "../services/firebase.dart";


class MeetingSettings extends StatefulWidget {
  @override
  _MeetingSettingsState createState() => _MeetingSettingsState();
}

class _MeetingSettingsState extends State<MeetingSettings> {
  TextEditingController controller = TextEditingController();
  var info;
  void getName() async
  {
 SharedPreferences pref = await SharedPreferences.getInstance();
  info =pref.getStringList('info');
  controller.text=info[0];
  setState(() {
    
  });
  }
  void initState()
  {
    super.initState();
    getName();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: CupertinoColors.systemPurple,title: Text("MEETING SETTINGS"),),
      body: Center(child: ListView(children:[
        SizedBox(height: 140,),
        Container(margin:EdgeInsets.only(left:50,right:50),child:TextField(controller: controller,decoration: InputDecoration(labelText: "Change Name"),)),
        FlatButton(child: Text("Change Name",style: TextStyle(color: CupertinoColors.systemPurple),),onPressed: () async{
           SharedPreferences pref = await SharedPreferences.getInstance();
  var info =pref.getStringList('info');
  info[0]=controller.text;
  pref.setStringList('info', info);
  FirebaseService.changeName(info[2], controller.text);
  Navigator.pop(context);
        },)
      
      ]))
    );
  }
}