import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillybrowser/models/user.dart';
class Conference extends StatefulWidget {
  @override
  _ConferenceState createState() => _ConferenceState();
}

class _ConferenceState extends State<Conference> {
  bool auth;
  User user;
  Widget drawer; 
  void checkAuth() async
  {
    SharedPreferences pref =await SharedPreferences.getInstance();
    if(pref.containsKey('info'))
    {
    auth=true;
    user=User(name:pref.getStringList('info')[0],number: pref.getStringList('info')[1],docid:pref.getStringList('info')[2]);
    setState((){});
    
    }
    else
    setState((){});

  }
  void initState()
  {
    super.initState();
    
    drawer=Drawer(child: ListView(children:[
    auth?UserAccountsDrawerHeader(accountName: Text(user.name), accountEmail: Text(user.number)):DrawerHeader(child: Text("Plz login")),
    auth?ListTile(leading: Icon(Icons.history),title: Text("History"),subtitle: Text("View Meeting Histories"),):null,
    auth?ListTile(leading: Icon(Icons.settings),title:Text("settings"),subtitle: Text('View settings'),):null,


  ]),);
    checkAuth();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}