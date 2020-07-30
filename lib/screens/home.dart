import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import './subscreens/pretabs.dart';
import './subscreens/animatedfloating.dart';
import './subscreens/urlbox.dart';
import './subscreens/newssubs.dart';
import '../services/history.dart';

class Home extends StatefulWidget {
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var news;
  TextEditingController url = TextEditingController();
  @override
  Widget build(BuildContext context) {
    news= ModalRoute.of(context).settings.arguments;
    return Scaffold(
      drawer: Drawer(child: Center(child:Text("COMING SOON MORE")),),
        backgroundColor: Colors.black,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          title: Text(
            'Skilly Browser',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          backgroundColor: Colors.purple,
          centerTitle: true,
          leading: FlatButton(
            onPressed: () {},
            child: Container(
                child: Icon(
              Icons.table_chart,
              color: Colors.white,
            )),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 9,
              ),
              Pretabs(),
              Urlbox(),
              SizedBox(
                height: 10,
              ),
              NewsSub(news:news['news']),
            ],
          ),
        ),
        floatingActionButton: Animatedfloating(news:news['news']));
  }
}
