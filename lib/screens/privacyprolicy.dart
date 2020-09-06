import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Privacy extends StatefulWidget {
  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff00011f),
        appBar: AppBar(
          title: Text('Privacy Policy'),
          centerTitle: true,
          backgroundColor: CupertinoColors.systemPurple,
        ),
        body: 
           Container(
             padding: EdgeInsets.all(20),
          child: Text(
            '''A Privacy Policy is a legal statement that specifies what the business owner does with the personal data collected from users, along with how the data is processed and for what purposes.

In 1968, Council of Europe did studies on the threat of the Internet expansion as they were concerned with the effects of technology on human rights. This lead to the development of policies that were to be developed to protect personal data.

This marks the start of what we know now as a "Privacy Policy." While the name "Privacy Policy" refers to the legal agreement, the concept of privacy and protecting user data is closely related. 

•	Permissions:- Camera Permission


We store the information of what you surf on the web for the record purpose

 ''',
            style: TextStyle(color: Colors.white),
          ),
        ));
  }
}
