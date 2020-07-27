import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController url = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          title: Text('SkillyBrowzer',style: TextStyle(color: Colors.teal),),
          backgroundColor: CupertinoColors.white,
          centerTitle: true,
          leading: FlatButton(
            onPressed: () {},
            child: Container(
                child: Icon(
              CupertinoIcons.add_circled,
              color: Colors.teal,
            )),
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 9,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                controller: url,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: "@ ENTER URL",
                ),
              ),
            ),
            
          ],
        ),
        floatingActionButton: AnimatedFloatingActionButton(
          colorStartAnimation: Colors.white70,
          colorEndAnimation: Colors.teal,
          animatedIconData: AnimatedIcons.view_list,
          fabButtons: <Widget>[
            FloatingActionButton(
                backgroundColor: Colors.teal,
                tooltip: 'NEWS',
                onPressed: () {},
                child: Icon(Icons.new_releases)),
            FloatingActionButton(
              tooltip: 'NEW TABS',
              backgroundColor: Colors.teal,
              onPressed: () {},
              child: Icon(Icons.tab),
            )
          ],
        ));
  }
}
