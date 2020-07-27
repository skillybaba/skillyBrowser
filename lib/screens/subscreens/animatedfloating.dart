import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
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
            backgroundColor: Colors.purple,
            tooltip: 'NEWS',
            onPressed: () {},
            child: Icon(Icons.new_releases)),
        FloatingActionButton(
          tooltip: 'NEW TABS',
          backgroundColor: Colors.purple,
          onPressed: () {},
          child: Icon(Icons.tab),
        )
      ],
    );
  }
}
