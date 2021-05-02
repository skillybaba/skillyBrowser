import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff00011f),
        appBar: AppBar(
          title: Text('AboutUs'),
          centerTitle: true,
          backgroundColor: CupertinoColors.systemPurple,
        ),
        body:  Center(child:Container(
            padding: EdgeInsets.all(20),
            child:
                 Column(children: [
                   SizedBox(height: 130,),
                  Image.asset('images/Icon-72.png'),
                  SizedBox(height: 30,),
              Text(
                '''Skilly Browser by Skillybaba 2021 Copyright

                           Version 2.0.1
             ''',
                style: TextStyle(color: Colors.white),
              ),
            ]))));
  }
}
