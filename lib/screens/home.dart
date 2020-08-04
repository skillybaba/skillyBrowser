import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import './subscreens/pretabs.dart';
import './subscreens/animatedfloating.dart';
import './subscreens/urlbox.dart';
import './subscreens/newssubs.dart';
import '../services/history.dart';
import 'package:animated_widgets/animated_widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var news;
  TextEditingController url = TextEditingController();
  @override
  Widget build(BuildContext context) {
    news = ModalRoute.of(context).settings.arguments;
    return TranslationAnimatedWidget(
        enabled: true, //update this boolean to forward/reverse the animation
        values: [
          Offset(0, 20), // disabled value value
          Offset(0, 25), //intermediate value
          Offset(0, 0) //enabled value
        ],
        child: Scaffold(
            drawer: Drawer(
              child: Center(child: Text("COMING SOON MORE")),
            ),
            backgroundColor: Colors.black,
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              title: Text(
                'SKILLY BROWSER',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: CupertinoColors.systemPurple,
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
                  NewsSub(news: news['news']),
                ],
              ),
            ),
            floatingActionButton: Animatedfloating(news: news['news'])));
  }
}
