import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "../models/newfourm.dart";
import "../services/newsforumService.dart";

class PannelList extends StatefulWidget {
  @override
  _PannelListState createState() => _PannelListState();
}

class _PannelListState extends State<PannelList> {
  bool search = false;
  TextEditingController controller = TextEditingController();
  List<NewsFourumModel> models = [];
  NewsForumService service = NewsForumService();
  List<NewsFourumModel> searchlist = [];
  filternews(String name) {
    this.searchlist = models.map((e) {
      if (e.pannelName.contains(name)) {
        return e;
      }
      return null;
    }).toList();
    print(this.searchlist);
    this.searchlist.removeWhere((element) => element == null);
  }

  getnews() async {
    
    var docs = await service.getNewsChats();
    
    docs.docs.forEach((element) {
      var data = element.data();
      if (data["s"] == "s") {
      } else {
        models.add(NewsFourumModel(
            pannelName: data["pannelname"],
            pannelid: data["pannelid"],
            docid: element.reference.path));
      }
    });
    searchlist = this.models;

    
    this.finalval = true;
    this.newsloading = true;
    setState(() {});
  }

  bool newsloading = false;
  bool finalval = false;
  @override
  Widget build(BuildContext context) {
    if (!this.newsloading) {
      print(2);
      getnews();
    }
    return Scaffold(
      backgroundColor: Color(0xff00011f),
      appBar: AppBar(
        backgroundColor: CupertinoColors.systemPurple,
        centerTitle: true,
        title: search
            ? TextField(
                controller: this.controller,
                onChanged: (String val) {
                  this.finalval = false;
                  if (val == "") {
                    this.searchlist = this.models;
                  } else
                    this.filternews(val);
                  this.finalval = true;
                  setState(() {});
                },
              )
            : Text(
                "News Forums",
                style: TextStyle(color: Colors.white),
              ),
        actions: [
          IconButton(
              icon: Icon(!search ? Icons.search : Icons.close),
              onPressed: () {
                this.finalval = false;
                this.searchlist = this.models;
                print(this.models);
                setState(() {
                  this.finalval = true;
                  this.search = !this.search;
                });
              })
        ],
      ),
      body: finalval
          ? ListView.builder(itemBuilder: (context, index) {
              if (index < this.searchlist.length) {
                return Container(
                    margin: EdgeInsets.all(10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: ListTile(
                          tileColor: CupertinoColors.systemPurple,
                          leading: Icon(
                            Icons.chat_bubble_outline_rounded,
                            color: Colors.white,
                          ),
                          title: Text(
                            this.searchlist[index].pannelName,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            "Click Here to join the discussion",
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, "/NewForum",
                                arguments: {
                                  "pannelname":
                                      this.searchlist[index].pannelName,
                                  "pannelid": this.searchlist[index].pannelid,
                                });
                          },
                        )));
              }
            })
          : SpinKitCircle(
              color: CupertinoColors.systemPurple,
              size: 50,
            ),
    );
  }
}
