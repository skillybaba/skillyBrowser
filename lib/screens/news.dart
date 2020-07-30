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
        color: Colors.black,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.purple,
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
                        color: Colors.grey[900],
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
                                      'http://skillybaba.pythonanywhere.com/' +
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
                          RaisedButton.icon(
                              color: Colors.purple,
                              onPressed: () {
                                Navigator.pushNamed(context, '/tabs',
                                    arguments: {
                                      'url': news[news.length - 1 - index]
                                          ['morelink'],
                                    });
                              },
                              label: Text(
                                'ReadMore',
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                              )),
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
