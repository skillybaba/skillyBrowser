import 'package:flutter/material.dart';
import './subscreens/newssubs.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
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
                                            loadingProgress.expectedTotalBytes),
                                  );
                                },
                                image: NetworkImage(
                                    'https://dynaimage.cdn.cnn.com/cnn/digital-images/org/09346fef-c333-4266-b17a-5fb1f9cbe43f.jpg'))),
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                                ''' President Trump's national security adviser,Robert O'Brien, has tested positive for coronavirus, 
 ''',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    decoration: TextDecoration.none))),
                        RaisedButton.icon(
                            color: Colors.purple,
                            onPressed: () {},
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
                },
              ),
            ),
          ],
        ));
  }
}
