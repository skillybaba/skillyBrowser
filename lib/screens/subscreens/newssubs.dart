import 'package:flutter/material.dart';
import 'package:animated_widgets/animated_widgets.dart';

class NewsSub extends StatefulWidget {
  var news;
  NewsSub({var news}) {
    this.news = news;
  }
  @override
  _NewsSubState createState() => _NewsSubState(news:news);
}

class _NewsSubState extends State<NewsSub> {
  var news;
  _NewsSubState({var news}) {
    this.news=news;
  }
  String newstext =
      ''' President Trump's national security adviser, Robert O'Brien, has tested positive for coronavirus, 
 ''';
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
                        color: Colors.white,
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
                        'http://skillybaba.pythonanywhere.com/'+news[news.length-1]['image']),
                    height: 220,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    news[news.length-1]['brief'],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
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
                        'http://skillybaba.pythonanywhere.com/'+news[news.length-2]['image']),
                    height: 220,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    news[news.length-2]['brief'],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlatButton.icon(
                  splashColor: Colors.purple[100],
                  color: Colors.purple,
                  onPressed: () {
                    Navigator.pushNamed(context, '/news',arguments:{
                      'news':news
                    });
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
