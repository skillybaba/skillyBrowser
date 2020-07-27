import './screens/home.dart';
import './screens/loading.dart';
import './screens/news.dart';

import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/':(context)=>Home(),

    },
  ));
}

