import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../tabs.dart';


class Pretabs extends StatefulWidget {
  @override
  _PretabsState createState() => _PretabsState();
}

class _PretabsState extends State<Pretabs> {
  

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20),
        // color: Colors.grey[900],
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10))),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      child: RaisedButton(
                    onPressed: () {
 Navigator.pushNamed(context,'/tabs' ,arguments: {'url':'https://www.instagram.com/'});
                    },
                    color: Colors.grey[900],
                    child: Image(
                        height: 50, image: AssetImage('images/insta.png')),
                  )),
                  Container(
                      child: RaisedButton(
                    onPressed: () {
                       Navigator.pushNamed(context,'/tabs' ,arguments: {'url':'https://www.facebook.com/'});
                    },
                    color: Colors.grey[900],
                    child: Image(
                        height: 50, image: AssetImage('images/facebook.png')),
                  )),
                  Container(
                      child: RaisedButton(
                    onPressed: () {
                       Navigator.pushNamed(context,'/tabs' ,arguments: {'url':'https://www.google.com/'});
                    },
                    color: Colors.grey[900],
                    child: Image(
                        height: 50, image: AssetImage('images/google.png')),
                  )),
                  Container(
                      height: 40,
                      width: 70,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        onPressed: () {
                        Navigator.pushNamed(context,'/tabs' ,arguments: {'url':"https://www.google.com/webhp?hl=en&sa=X&ved=0ahUKEwjq8NaJie_qAhVRIbcAHSwAA2gQPAgH"});
                        },
                        child: Icon(Icons.add),
                      )),
                ],
              )
            ],
          ),
        ));
  }
}
