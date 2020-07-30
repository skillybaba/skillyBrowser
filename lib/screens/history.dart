import 'package:flutter/material.dart';
import '../services/history.dart';

class HistoryScreen extends StatefulWidget {

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
 
  Map args;
  

  @override
  Widget build(BuildContext context) {
     args = ModalRoute.of(context).settings.arguments;
    
    print(args['histories'].val);
    return Container();
  }
}
