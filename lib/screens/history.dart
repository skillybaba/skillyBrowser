import 'package:flutter/material.dart';
import '../services/history.dart';

import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Map args;
  var list;
  bool sta = false;
  String text({String str}) {
    if (str.contains('https://www.google.com/search?-b-d&q=')) {
      return str.substring(37);
    } else {
      return str;
    }
  }

  valueint() async {
    if (!sta) {
      await getvalue('history');
      setState(() {
        sta = true;
      });
    }
  }

  value() async {
    valueint();
    var list2 = [];
    if (ret() != null) {
      list2 = ret();
    }

    this.list = list2;
  }

  @override
  Widget build(BuildContext context) {
    value();
    print(list);
    args = ModalRoute.of(context).settings.arguments;
    if (sta) {
      return Center(
          child: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
                actions: <Widget>[
                  RaisedButton.icon(
                      color: Colors.grey[800],
                      onPressed: () {
                        Navigator.pop(context);

                        delete("history");
                      },
                      icon: Icon(Icons.delete, color: Colors.purple),
                      label: Text(
                        'Delete',
                        style: TextStyle(color: Colors.purple),
                      ))
                ],
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                ),
                pinned: true,
                expandedHeight: 130.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'HISTORIES',
                    style: TextStyle(color: Colors.purple),
                  ),
                )),
            SliverList(delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              double i = 120;
              
              if ((index < list.length) &&
                  (!list[index].contains('www.') &&
                      (!list[index].contains('.com')) &&
                      (!list[index].contains('https://')) &&
                      (list[index].substring(37).length > 20))) {
                i = 10;
              } else {
                i = 10;
              }
              if (index < list.length) {
                return Container(
                  padding: EdgeInsets.all(9),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Row(
                    children: <Widget>[
                      FlatButton.icon(
                        padding: EdgeInsets.only(left: i),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, "/tabs",
                              arguments: {
                                'url': list[index],
                              });
                        },
                        icon: Icon(
                          Icons.history,
                          color: Colors.white,
                        ),
                        label: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              text(str: list[index]),
                              style: TextStyle(color: Colors.white),
                              maxLines: 4,
                              overflow: TextOverflow.fade,
                              softWrap: true,
                            )),
                      ),
                    ],
                  ),
                );
              } else {
                return null;
              }
            }))
          ],
        ),
      ));
    }
    return Center(
        child: SpinKitCircle(
      color: Colors.purple,
    ));
  }
}
