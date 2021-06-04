import './screens/home.dart';
import './screens/loading.dart';
import './screens/news.dart';
import './screens/tabs.dart';
import 'package:flutter/material.dart';
import './screens/history.dart';
import './screens/camera.dart';
import './screens/pdfview.dart';
import './screens/privacyprolicy.dart';
import './screens/aboutus.dart';
import './screens/meethistory.dart';
import "./screens/confrence.dart";
import "./screens/meetingsettings.dart";
import "./screens/globalchat.dart";
import "./screens/newsforumpannel.dart";
import "./screens/pannellist.dart";

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
      '/Privacy': (context) => Privacy(),
      '/AboutUs': (context) => AboutUs(),
      "/Conference": (context) => Conference(),
      "/MeetingHistory": (context) => MeetingHistory(),
      "/MeetingSettings": (context) => MeetingSettings(),
      "/GlobalChat": (context) => GlobalChat(),
      "/NewForum": (context) => NewsFourm(),
      "/PannelList":(context)=>PannelList(),
    },
  ));
}
