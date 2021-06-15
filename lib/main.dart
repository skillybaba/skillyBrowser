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

import 'package:page_transition/page_transition.dart';
import 'package:native_state/native_state.dart'; //for saving minimal state of pages over the app screens even when app is killed


void main() => runApp(SavedState(child: MyApp(),));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var savedState = SavedState.of(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // restore the route or default to the home page:-
        initialRoute: SavedStateRouteObserver.restoreRoute(savedState) ?? "/",

        // To Setup an observer that will save the current route into the saved state:-
        navigatorObservers: [SavedStateRouteObserver(savedState: savedState)],
        routes: {
          '/': (context) => Loading(),

          '/home': (context) => SavedState.builder(builder: (context , savedState) => Home(savedState: savedState),), //for saving the minimal state of the home screen even when the app is killed

          "/tabs": (context) => Tabs(),
          "/news": (context) => News(),
          '/histroy': (context) => HistoryScreen(),
          //'/Camera': (context) => CameraScreen(),
          '/PDF': (context) => PDFViewer(),
          //'/Privacy': (context) => Privacy(),
          //'/AboutUs': (context) => AboutUs(),
          //"/Conference": (context) => Conference(),
          "/MeetingHistory": (context) => MeetingHistory(),
          "/MeetingSettings": (context) => MeetingSettings(),
          "/GlobalChat": (context) => GlobalChat(),
          "/NewForum": (context) => NewsFourm(),
          //"/PannelList":(context)=>PannelList(),
        },
        //whenever pushnamed of the following named route will be called this transition will take place
        /*onGenerateRoute: (settings) {
          if(settings.name == "/news"){
            return PageTransition(type: PageTransitionType.rotate, duration: Duration(seconds: 1), child: News(), );
          }
          else{
            return null;
          }
        }*/
    );
  }
}
