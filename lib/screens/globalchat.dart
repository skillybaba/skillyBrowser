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

class GlobalChat extends StatefulWidget {
  @override
  _GlobalChatState createState() => _GlobalChatState();
}

class _GlobalChatState extends State<GlobalChat> {
  GlobalKey<DashChatState> key = GlobalKey<DashChatState>();
  List<ChatMessage> message = [];
  User user;
  bool auth = false;
  Map chatMap = {};
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
  StreamSubscription<QuerySnapshot> snap;
  void getChats() async {
    this.loading=true;
    await Firebase.initializeApp();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var collection = firestore.collection("message");
   this.snap= collection.snapshots().listen((event) {
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
          this.loading=false;
        });
        this.first = true;
      } else {

        event.docChanges.forEach((element) {
          var data = element.doc.data();
          this.message.add(ChatMessage(
              text: data['text'],
              image: data['image'],
              createdAt: data['datetime'].toDate(),
              user: ChatUser(
                  name: data['user']['name'],
                  uid: data['user']['number'],
                  avatar: data['user']['avatar'])));
        });
        setState(() {
          
        });
      }
    });
  }
  void dispose()
  {
    super.dispose();
    this.snap.cancel();
  }
  void initState()
  {
    super.initState();
    checkAuth();
    getChats();
  }
  getImages(type) async{
    var image = await ChatService.getImages(color:CupertinoColors.systemPurple,backgroundcolor:Colors.grey,type:type);
    return image;
  }
  bool loading=false;
  @override
  Widget build(BuildContext context) {

    if (!auth)
      return Login(type:"Global",next: (number, docid) async {
        this.setState(() {
          this.auth = true;
          checkAuth();
        });
      });
    else
      return Scaffold(
        backgroundColor: Color(0xffE9CFEC),
        appBar: AppBar(
          backgroundColor: CupertinoColors.systemPurple,
          title: Text("Skilly Global"),
        ),
        body:LoadingOverlay(child: DashChat(
          alwaysShowSend: true,
         
          trailing: [IconButton(onPressed: (){
            showDialog(context: context,builder: (context){
              return AlertDialog(title: Text("Select One"),content: Container(
                height: 210
                ,
                child:ListView(children: [
                ListTile(leading: Icon(Icons.camera),title:Text("Camera"),subtitle: Text("Select from camera"),onTap: ()async{
                 setState(() {
                   this.loading=true;
                 });
                  var image = await this.getImages('camera');

  Navigator.pop(context);
                   await ChatService(user: this.user).addMessage("Media",image);
setState(() {
  this.loading=false;
});
                 
                },),
                  ListTile(leading: Icon(Icons.picture_in_picture_alt),title:Text("Gallery"),subtitle: Text("Select from gallery"),onTap: ()async{
                  setState(() {
                    this.loading=true;
                  });
                  var image = await this.getImages("gallery");
                  Navigator.pop(context);
                   await ChatService(user: this.user).addMessage("Media",image);
                   setState(() {
                     this.loading=false;
                   });
                   
                },),
              ],),));
            });
          }, icon: Icon(Icons.attach_file_rounded,color: CupertinoColors.systemPurple,))],
          scrollToBottom: true,
          key: this.key,
          messages: this.message,
          user: ChatUser(name:this.user.name,avatar: this.user.dp),
          onSend: (message) {
            ChatService(user: this.user).addMessage(message.text,message.image);
          },
        ),
      isLoading: loading,));
  }
}
