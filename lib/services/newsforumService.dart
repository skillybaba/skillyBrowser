import "./firebase.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
class NewsForumService {
  String name;
  NewsForumService({name}) {
    if (name == null) {
      this.name = "all";
    } else
      this.name = name;
  }
  Future<QuerySnapshot> getNewsChats() async {
    var docs = await FirebaseService.newsfourm(name: this.name);
    return docs;
  }
}
