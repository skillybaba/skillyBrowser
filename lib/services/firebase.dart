import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import "dart:io";
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class FirebaseService
{
  File file;
  FirebaseService({File file})
  {
    this.file=file;

  }
  auth({String name,String phonenumber,String route,context}) async{
    TextEditingController controller  = TextEditingController();
    await Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.verifyPhoneNumber(phoneNumber: phonenumber, verificationCompleted: (credential) async{
      var user = await auth.signInWithCredential(credential);
      if(user!=null)
      {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        var collection = firestore.collection('users');
        SharedPreferences pref = await SharedPreferences.getInstance();
     
        var doc =  await collection.add({
          "number":phonenumber,
          "name":name,
        });
           await pref.setStringList("info", [name,phonenumber,doc.path]);

      Navigator.popAndPushNamed(context, route);
      }
      else
      Alert(context: context,title: "Error",type:AlertType.error).show();

    }, verificationFailed: (exception){
      Alert(context: context,title:'Some Error with ${exception.phoneNumber} to login',type: AlertType.error).show();
    }, codeSent: (String verfication,int token){
      showDialog(context: context,builder:(context)=>AlertDialog(content: TextField(controller: controller,),actions: [FlatButton(onPressed: () async{
      var credential = PhoneAuthProvider.credential(verificationId: verfication, smsCode: controller.text);
      var user = await auth.signInWithCredential(credential);
  if(user!=null)
      {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        var collection = firestore.collection('users');
        SharedPreferences pref = await SharedPreferences.getInstance();
     
        var doc =  await collection.add({
          "number":phonenumber,
          "name":name,
        });
           await pref.setStringList("info", [name,phonenumber,doc.path]);

      Navigator.popAndPushNamed(context, route);
      }
      else
      Alert(context: context,title: "Error",type:AlertType.error).show();
      }, child: null)],));
    }, codeAutoRetrievalTimeout: (String error){
Alert(context: context,title: "Timeout",type:AlertType.error).show();
    });
  }
  uploadFunction() async
  {
    await Firebase.initializeApp();
    FirebaseStorage storage = FirebaseStorage.instance;
    var imgref = storage.ref().child('images/'+DateTime.now().toString());
    var uploadref = imgref.putFile(this.file);
    var upload = await uploadref.onComplete;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var doc = firestore.collection("Images");
    doc.add({
      "time":DateTime.now(),
      "imgLink":await upload.ref.getDownloadURL(),
    });
  }
}