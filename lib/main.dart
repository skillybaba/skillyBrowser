import 'package:skillybrowser/services/history.dart';
import './screens/home.dart';
import './screens/loading.dart';
import './screens/news.dart';
import './screens/tabs.dart';
import './screens/news.dart';
import 'package:flutter/material.dart';
import './screens/history.dart';
import './screens/loading.dart';
import './screens/camera.dart';
import './screens/pdfview.dart';
import './screens/privacyprolicy.dart';
import './screens/aboutus.dart';
void main() {
  runApp(MaterialApp(
    
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      "/tabs": (context) => Tabs(),
      "/news": (context) => News(),
      '/histroy': (context) => HistoryScreen(),
      '/Camera': (context) => CameraScreen(),
      '/PDF': (context) => PDFViewer(),
      '/Privacy':(context) => Privacy(),
      '/AboutUs' : (context) => AboutUs(),
    },
  ));
}
