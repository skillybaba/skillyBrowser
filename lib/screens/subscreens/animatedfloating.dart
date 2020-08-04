import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:skillybrowser/services/history.dart';

class Animatedfloating extends StatefulWidget {
  var news;
  Animatedfloating({var news}) {
    this.news = news;
  }
  @override
  _AnimatedfloatingState createState() => _AnimatedfloatingState(news:news);
}

class _AnimatedfloatingState extends State<Animatedfloating> {
  var news;
  _AnimatedfloatingState({var news}) {
    this.news = news;
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedFloatingActionButton(
      colorStartAnimation: CupertinoColors.systemPurple,
      colorEndAnimation: CupertinoColors.systemPurple,
      animatedIconData: AnimatedIcons.view_list,
      fabButtons: <Widget>[
        FloatingActionButton(
            heroTag: 'news',
            backgroundColor: CupertinoColors.systemPurple,
            tooltip: 'NEWS',
            onPressed: () {
              Navigator.pushNamed(context, "/news",arguments: {
                'news':news
              });
            },
            child: Icon(Icons.new_releases)),
        FloatingActionButton(
          heroTag: 'history',
          tooltip: 'History',
          backgroundColor: CupertinoColors.systemPurple,
          onPressed: () {
            Navigator.pushNamed(context, '/histroy', arguments: {});
          },
          child: Icon(Icons.history),
        ),
        FloatingActionButton(
          heroTag: 'newtab',
          tooltip: 'NEW TABS',
          backgroundColor: CupertinoColors.systemPurple,
          onPressed: () {
            Navigator.pushNamed(context, '/tabs', arguments: {
              'url':
                  'https://www.google.com/webhp?hl=en&sa=X&ved=0ahUKEwjq8NaJie_qAhVRIbcAHSwAA2gQPAgH',
            });
          },
          child: Icon(Icons.add_circle_outline),
        )
      ],
    );
  }
}
