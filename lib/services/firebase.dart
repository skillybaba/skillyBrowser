import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import "dart:io";
import 'package:rflutter_alert/rflutter_alert.dart';
export 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseService {
  File file;
  FirebaseService({File file}) {
    this.file = file;
  }
  static bool authDone = false;
  static DocumentReference doc;
  static meetingStore(
      {String roomid, String hostnumber, String hostdocid}) async {
    await Firebase.initializeApp();

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var doc = firestore.doc(hostdocid);

    doc.collection('meetings').add({
      'roomid': roomid,
      "hostname": hostnumber,
    });
    var doc2 = firestore.collection("meetings");
    doc2.add({
      'roomid': roomid,
      "hostname": hostnumber,
    });
  }

  static checkRoom(roomid) async {
    await Firebase.initializeApp();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var doc = firestore.collection('meetings');
    var checkRoom = await doc.where("roomid", isEqualTo: roomid).get();
    if (checkRoom.docs.length > 0) {
      return true;
    }
    return false;
  }

  static void changeName(docid, name) async {
    await Firebase.initializeApp();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var doc = firestore.doc(docid);
    doc.update({'name': name});
  }

  static Future<List<QueryDocumentSnapshot>> getMeetings(docid) async {
    await Firebase.initializeApp();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var doc = firestore.doc(docid).collection('meetings');
    var list = await doc.get();
    return list.docs;
  }

  static auth(
      {String name, String phonenumber, String route, context, next}) async {
    TextEditingController controller = TextEditingController();
    await Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;
    bool val = false;
    await auth.verifyPhoneNumber(
        phoneNumber: phonenumber,
        verificationCompleted: (credential) async {
          var user = await auth.signInWithCredential(credential);
          if (user != null) {
            FirebaseFirestore firestore = FirebaseFirestore.instance;
            var collection = firestore.collection('users');

            SharedPreferences pref = await SharedPreferences.getInstance();
            var ref =
                await collection.where("number", isEqualTo: phonenumber).get();
            if (ref.docs.length > 0) {
              FirebaseService.doc = ref.docs.first.reference;
              await pref.setStringList("info", [
                ref.docs.first.data()['name'],
                phonenumber,
                FirebaseService.doc.path
              ]);
            } else {
              FirebaseService.doc = await collection.add({
                "number": phonenumber,
                "name": name,
              });
              await pref.setStringList(
                  "info", [name, phonenumber, FirebaseService.doc.path]);
            }
            if (val) Navigator.pop(context);
            next(FirebaseService.doc);
          } else
            Alert(context: context, title: "Error", type: AlertType.error)
                .show();
        },
        verificationFailed: (exception) {
          Alert(
                  context: context,
                  title: 'Some Error with ${exception.phoneNumber} to login',
                  type: AlertType.error)
              .show();
        },
        codeSent: (String verfication, int token) {
          val = true;
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Enter OTP"),
                    content: TextField(
                      controller: controller,
                    ),
                    actions: [
                      FlatButton(
                          onPressed: () async {
                            var credential = PhoneAuthProvider.credential(
                                verificationId: verfication,
                                smsCode: controller.text);
                            var user =
                                await auth.signInWithCredential(credential);
                            if (user != null) {
                              FirebaseFirestore firestore =
                                  FirebaseFirestore.instance;
                              var collection = firestore.collection('users');

                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              var ref = await collection
                                  .where("number", isEqualTo: phonenumber)
                                  .get();
                              if (ref.docs.length > 0) {
                                FirebaseService.doc = ref.docs.first.reference;
                                await pref.setStringList("info", [
                                  ref.docs.first.data()['name'],
                                  phonenumber,
                                  FirebaseService.doc.path
                                ]);
                              } else {
                                FirebaseService.doc = await collection.add({
                                  "number": phonenumber,
                                  "name": name,
                                });
                                await pref.setStringList("info", [
                                  name,
                                  phonenumber,
                                  FirebaseService.doc.path
                                ]);
                              }

                              Navigator.pop(context);
                              next(FirebaseService.doc);
                            } else
                              Alert(
                                      context: context,
                                      title: "Error",
                                      type: AlertType.error)
                                  .show();
                          },
                          child: Text("next"))
                    ],
                  ));
        },
        codeAutoRetrievalTimeout: (String error) {
          Alert(context: context, title: "Timeout", type: AlertType.error)
              .show();
        });
  }

  uploadFunction() async {
    await Firebase.initializeApp();
    FirebaseStorage storage = FirebaseStorage.instance;
    var imgref = storage.ref().child('images/' + DateTime.now().toString());
    var uploadref = imgref.putFile(this.file);
    var upload = await uploadref.onComplete;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var doc = firestore.collection("Images");
    doc.add({
      "time": DateTime.now(),
      "imgLink": await upload.ref.getDownloadURL(),
    });
  }
}
