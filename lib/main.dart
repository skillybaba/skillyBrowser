import 'package:skillybrowser/services/history.dart';

import './screens/home.dart';
import './screens/loading.dart';
import './screens/news.dart';
import './screens/tabs.dart';
import './screens/news.dart';
import 'package:flutter/material.dart';
import './screens/history.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      "/tabs": (context) => Tabs(),
      "/news": (context) => News(),
      '/histroy': (context) => HistoryScreen(),
    },
  ));
}
