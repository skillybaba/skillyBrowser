import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_widgets/animated_widgets.dart';

class NewsSub extends StatefulWidget {
  var news;
  NewsSub({var news}) {
    this.news = news;
  }
  @override
  _NewsSubState createState() => _NewsSubState(news: news);
}

class _NewsSubState extends State<NewsSub> {
  var news;
  _NewsSubState({var news}) {
    this.news = news;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: OpacityAnimatedWidget.tween(
        opacityEnabled: 1,
        opacityDisabled: 0,
        enabled: true,
        child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: SingleChildScrollView(
                child: Container(
                    child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Text(
                    "NEWS UPDATES",
                    style: TextStyle(
                        color: CupertinoColors.systemPurple,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Image(
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) {
                        return Center(child: child);
                      }
                      return Center(
                        child: CircularProgressIndicator(
                            value: loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes),
                      );
                    },
                    image: NetworkImage(
                        'http://skillybaba.pythonanywhere.com/' +
                            news[news.length - 1]['image']),
                    height: 220,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    news[news.length - 1]['brief'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Center(
                      child: RaisedButton.icon(
                    color: Colors.grey[900],
                    onPressed: () {
                      Navigator.pushNamed(context, '/tabs', arguments: {
                        'url': news[news.length - 1]['morelink'],
                      });
                    },
                    icon: Icon(Icons.more_horiz, color: CupertinoColors.systemPurple),
                    label: Text("READ MORE",
                        style: TextStyle(color: CupertinoColors.systemPurple,),
                        ),
                  )),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Image(
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) {
                        return Center(child: child);
                      }
                      return Center(
                        child: CircularProgressIndicator(
                            value: loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes),
                      );
                    },
                    image: NetworkImage(
                        'http://skillybaba.pythonanywhere.com/' +
                            news[news.length - 2]['image']),
                    height: 220,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Text(
                    news[news.length - 2]['brief'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Center(
                      child: RaisedButton.icon(
                    color: Colors.grey[900],
                    onPressed: () {
                      Navigator.pushNamed(context, '/tabs', arguments: {
                        'url': news[news.length - 2]['morelink'],
                      });
                    },
                    icon: Icon(Icons.more_horiz, color: CupertinoColors.systemPurple),
                    label: Text("READ MORE",
                        style: TextStyle(color: CupertinoColors.systemPurple)),
                  )),
                ),
                SizedBox(
                  height: 40,
                ),
                FlatButton.icon(
                  splashColor: Colors.purple[300],
                  color: CupertinoColors.systemPurple,
                  onPressed: () {
                    Navigator.pushNamed(context, '/news',
                        arguments: {'news': news});
                  },
                  icon: Icon(Icons.add, color: Colors.black),
                  label: Text("MORE", style: TextStyle(color: Colors.black)),
                ),
              ],
            )))),
      ),
    );
  }
}
