import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillybrowser/models/user.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<ScaffoldState> key =  GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: key,
    
      appBar: AppBar(leading: IconButton(onPressed: (){
        key.currentState.openDrawer();

      },icon: Icon(Icons.view_sidebar),),title: Text("Skilly Meet"),

    
      ),
      body: Container(
        child: Center(),
      ),
    );
    
  }
}