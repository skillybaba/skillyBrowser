import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:skillybrowser/services/history.dart';

class Animatedfloating extends StatefulWidget {
  @override
  _AnimatedfloatingState createState() => _AnimatedfloatingState();
}

class _AnimatedfloatingState extends State<Animatedfloating> {
  @override
  Widget build(BuildContext context) {
    return AnimatedFloatingActionButton(
      colorStartAnimation: Colors.purple,
      colorEndAnimation: Colors.purple,
      animatedIconData: AnimatedIcons.view_list,
      fabButtons: <Widget>[
        FloatingActionButton(
            heroTag: 'news',
            backgroundColor: Colors.purple,
            tooltip: 'NEWS',
            onPressed: () {
              Navigator.pushNamed(context, "/news");
            },
            child: Icon(Icons.new_releases)),
        FloatingActionButton(
          heroTag: 'history',
          tooltip: 'History',
          backgroundColor: Colors.purple,
          onPressed: () {
            Navigator.pushNamed(context, '/histroy', arguments: {});
          },
          child: Icon(Icons.history),
        ),
        FloatingActionButton(
          heroTag: 'newtab',
          tooltip: 'NEW TABS',
          backgroundColor: Colors.purple,
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
