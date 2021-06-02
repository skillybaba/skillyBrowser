import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dash_chat/dash_chat.dart';
import "../services/chatService.dart";
import "../models/user.dart";
import "./subscreens/login.dart";
import "dart:async";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loading_overlay/loading_overlay.dart';
import "dart:io";
import "../services/firebase.dart";

class NewsFourm extends StatefulWidget {
  @override
  _NewsFourmState createState() => _NewsFourmState();
}

class _NewsFourmState extends State<NewsFourm> {
  GlobalKey<DashChatState> key = GlobalKey<DashChatState>();
  List<ChatMessage> message = [];
  User user;
  bool auth = false;
  Map chatMap = {};
  bool msg = false;
  void checkAuth() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('info')) {
      auth = true;
      user = User(
          name: pref.getStringList('info')[0],
          number: pref.getStringList('info')[1],
          docid: pref.getStringList('info')[2]);
      setState(() {});
    } else
      setState(() {});
  }

  bool first = false;
  String pannelname;
  var routedata;
  String pannelid;
  StreamSubscription<QuerySnapshot> snap;
  void getChats() async {
    this.routedata = ModalRoute.of(context).settings.arguments;
    this.pannelname = this.routedata["pannelname"];
    this.pannelid = this.routedata["pannelid"];
    this.loading = true;
    print(1);

    await Firebase.initializeApp();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var collection = firestore.collection("pannels");
    print(await FirebaseService.checkPannel(pannelid));
    if (!(await FirebaseService.checkPannel(pannelid))) {
      await ChatService(
              user: User(
                  docid: "null",
                  dp: "null",
                  name: "Skilly Browser",
                  number: "null"))
          .addMessagInNewsForum(pannelid, "Welcome to the $pannelname", null);
    }
    var doc2 = await collection.where("pannelid", isEqualTo: pannelid).get();

    // var doc2 = collection.doc("GDFAGprmBb9aTiwBqMJ3");

    // doc2.docs.forEach((element) {
    //   print(element.data());
    // });
    // print(doc2.docs.length);

    var collection2 = doc2.docs[0].reference.collection("message");
    if (auth) {
      this.snap = collection2.snapshots().listen((event) {
        this.msg = true;
        if (!this.first) {
          event.docChanges.forEach((element) {
            var data = element.doc.data();
            chatMap[data['datetime'].toString()] = data;
          });
          var list = this.chatMap.keys.toList();
          list.sort();
          list.forEach((element) {
            this.message.add(ChatMessage(
                text: chatMap[element]['text'],
                image: chatMap[element]['image'],
                createdAt: chatMap[element]['datetime'].toDate(),
                user: ChatUser(
                    name: chatMap[element]['user']['name'],
                    uid: chatMap[element]['user']['number'],
                    avatar: chatMap[element]['user']['avatar'])));
          });
          setState(() {
            this.loading = false;
          });
          this.first = true;
        } else {
          event.docChanges.forEach((element) {
            var data = element.doc.data();
            print(data);
            this.message.add(ChatMessage(
                text: data['text'],
                image: data['image'],
                createdAt: data['datetime'].toDate(),
                user: ChatUser(
                    name: data['user']['name'],
                    uid: data['user']['number'],
                    avatar: data['user']['avatar'])));
          });
          setState(() {});
        }
      });
    }
  }

  void dispose() {
    super.dispose();
    this.snap.cancel();
  }

  void initState() {
    super.initState();
    checkAuth();
  }

  getImages(type) async {
    var image = await ChatService.getImages(
        color: CupertinoColors.systemPurple,
        backgroundcolor: Colors.grey,
        type: type);
    return image;
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    this.routedata = ModalRoute.of(context).settings.arguments;
    this.pannelname = this.routedata["pannelname"];
    this.pannelid = this.routedata["pannelid"];
    if (!auth)
      return Login(
          type: "Global",
          next: (number, docid) async {
            this.setState(() {
              this.auth = true;
              checkAuth();
            });
          });
    else {
      if (!this.msg) {
        this.getChats();
      }
      return Scaffold(
          backgroundColor: Color(0xffE9CFEC),
          appBar: AppBar(
            backgroundColor: CupertinoColors.systemPurple,
            title: Text(this.pannelname),
          ),
          body: LoadingOverlay(
            child: DashChat(
              alwaysShowSend: true,
              trailing: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                title: Text("Select One"),
                                content: Container(
                                  height: 210,
                                  child: ListView(
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.camera),
                                        title: Text("Camera"),
                                        subtitle: Text("Select from camera"),
                                        onTap: () async {
                                          setState(() {
                                            this.loading = true;
                                          });
                                          var image =
                                              await this.getImages('camera');

                                          Navigator.pop(context);
                                          await ChatService(user: this.user)
                                              .addMessage("Media", image);
                                          setState(() {
                                            this.loading = false;
                                          });
                                        },
                                      ),
                                      ListTile(
                                        leading:
                                            Icon(Icons.picture_in_picture_alt),
                                        title: Text("Gallery"),
                                        subtitle: Text("Select from gallery"),
                                        onTap: () async {
                                          setState(() {
                                            this.loading = true;
                                          });
                                          var image =
                                              await this.getImages("gallery");
                                          Navigator.pop(context);
                                          await ChatService(user: this.user)
                                              .addMessage("Media", image);
                                          setState(() {
                                            this.loading = false;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ));
                          });
                    },
                    icon: Icon(
                      Icons.attach_file_rounded,
                      color: CupertinoColors.systemPurple,
                    ))
              ],
              scrollToBottom: true,
              key: this.key,
              messages: this.message,
              user: ChatUser(name: this.user.name, avatar: this.user.dp),
              onSend: (message) {
                ChatService(user: this.user).addMessagInNewsForum(
                    pannelid, message.text, message.image,pannelname);
              },
            ),
            isLoading: loading,
          ));
    }
  }
}
