import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './subscreens/newssubs.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  var news;
  @override
  Widget build(BuildContext context) {
    news = ModalRoute.of(context).settings.arguments;
    news = news['news'];
    print(news);
    return Container(
        color: Color(0xff00011f),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: CupertinoColors.systemPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              pinned: true,
              expandedHeight: 150.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('!NEWS!'),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index < news.length) {
                    return Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff040523),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Image(
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) {
                                      return Center(child: child);
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                          value: loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress
                                                  .expectedTotalBytes),
                                    );
                                  },
                                  image: NetworkImage(
                                      'https://skillybaba.pythonanywhere.com/' +
                                          news[news.length - 1 - index]
                                              ['image']))),
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                  news[news.length - 1 - index]['brief'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      decoration: TextDecoration.none))),
                          Row(
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              RaisedButton.icon(
                                  color: Color(0xff040523),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/tabs',
                                        arguments: {
                                          'url': news[news.length - 1 - index]
                                              ['morelink'],
                                        });
                                  },
                                  label: Text(
                                    'ReadMore',
                                    style: TextStyle(
                                        color: CupertinoColors.systemPurple),
                                  ),
                                  icon: Icon(
                                    Icons.more_horiz,
                                    color: CupertinoColors.systemPurple,
                                  )),
                              TextButton.icon(
                                  onPressed: () {
                                     Navigator.popAndPushNamed(context, "/NewForum",
                              arguments: {
                                "pannelname":news[news.length - 1 - index]['brief'],
                              "pannelid":news[news.length - 1 - index]['id'].toString(),
                              
                              });
                                  },
                                  icon: Icon(
                                    Icons.chat_bubble,
                                    color: CupertinoColors.systemPurple,
                                  ),
                                  label: Text(
                                    "Debate",
                                    style: TextStyle(
                                        color: CupertinoColors.systemPurple),
                                  ))
                            ],
                          )
                        ],
                      ),
                    );
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ],
        ));
  }
}
