import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// https://www.google.com/search?q=kanishk
class Urlbox extends StatefulWidget {
  @override
  _UrlboxState createState() => _UrlboxState();
}

class _UrlboxState extends State<Urlbox> {
  TextEditingController url = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: TextField(
        onEditingComplete: () {
          if (url.text.contains('https://')) {
            Navigator.pushNamed(context, '/tabs', arguments: {'url': url.text});
          } else if(url.text.contains('.com')) {
            Navigator.pushNamed(context, '/tabs',
                arguments: {'url': "https://" + url.text});
          }
          else{
             Navigator.pushNamed(context, '/tabs',
                arguments: {'url': "https://www.google.com/search?-b-d&q=" + url.text});
          }
        },
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        controller: url,
        autocorrect: true,
        decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            fillColor: Colors.white,
            focusColor: Colors.white,
            hoverColor: Colors.white,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            icon: Icon(
              Icons.alternate_email,
              color: CupertinoColors.systemPurple,
            ),
            hintText: 'ENTER THE URL'),
      ),
    );
  }
}
