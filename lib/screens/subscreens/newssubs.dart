import 'package:flutter/material.dart';
import 'package:animated_widgets/animated_widgets.dart';

class NewsSub extends StatefulWidget {
  @override
  _NewsSubState createState() => _NewsSubState();
}

class _NewsSubState extends State<NewsSub> {
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
                        'https://dynaimage.cdn.cnn.com/cnn/digital-images/org/09346fef-c333-4266-b17a-5fb1f9cbe43f.jpg'),
                    height: 220,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    newstext,
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
                        'https://dynaimage.cdn.cnn.com/cnn/digital-images/org/09346fef-c333-4266-b17a-5fb1f9cbe43f.jpg'),
                    height: 220,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    newstext,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlatButton.icon(
                  splashColor: Colors.purple[100],
                  color: Colors.purple,
                  onPressed: () {
                    Navigator.pushNamed(context, '/news');
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
