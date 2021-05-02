import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import "package:skillybrowser/services/firebase.dart";

class Login extends StatefulWidget {
  var next;
  var type = "Meet";
  Login({key, next, type = "Meet"}) : super(key: key) {
    this.next = next;
    this.type = type;
  }
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  String code = "+91";
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffE9CFEC),
        key: key,
        floatingActionButton: FloatingActionButton(
          backgroundColor: CupertinoColors.systemPurple,
          child: Icon(Icons.navigate_next),
          onPressed: () async {
            await FirebaseService.auth(
                phonenumber: code + controller.text,
                context: context,
                next: (docid) {
                  this.widget.next(code + controller.text, docid);
                });
          },
        ),
        appBar: AppBar(
          backgroundColor: CupertinoColors.systemPurple,
          title: Text(widget.type == "Meet"
              ? "Skilly Meet Login"
              : "Global Chat Login"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 130,
                ),
                CountryCodePicker(
                  onChanged: (code) {
                    this.code = code.code;
                  },
                  initialSelection: "+91",
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: controller,
                    decoration: InputDecoration(
                        labelText: "Enter the Phone Number",
                        hintText: "with out country code",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  margin: EdgeInsets.only(left: 50, right: 50),
                ),
              ],
            ),
          ),
        ));
  }
}
