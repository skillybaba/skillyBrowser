import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "../services/firebase.dart";
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meetingHistoryModel.dart';
import "../services/conferenceservice.dart";

class MeetingHistory extends StatefulWidget {
  @override
  _MeetingHistoryState createState() => _MeetingHistoryState();
}

class _MeetingHistoryState extends State<MeetingHistory> {
  List meetingHistory=[];
  bool meetingres=false;
  getMeetings() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
   var  docs = await FirebaseService.getMeetings(pref.getStringList("info")[2]);
    docs.forEach((element) {
      var data=element.data();
  
      meetingHistory.add(MeetingHistoryModel(roomid: data['roomid'],number: data['number']));
   

     });
     setState(() {
       meetingres=true;
     });
  }
  void initState()
  {
    super.initState();
    getMeetings();
  }
  @override
  Widget build(BuildContext context) {
    if(this.meetingres)
    return Scaffold(
      appBar: AppBar(title: Text("Meeting History"),backgroundColor: CupertinoColors.systemPurple,),
      body: CustomScrollView(slivers: [
        SliverList(delegate: SliverChildBuilderDelegate((context,index){
          if(index<meetingHistory.length)
          return ListTile(leading: Icon(Icons.merge_type_outlined),title: Text(meetingHistory[index].roomid),subtitle: Text('JOIN AGAIN'),onTap: (){
          ConferenceService(roomid: meetingHistory[index].roomid).hostMeeting('rejoin');
          },);
        }),)
      ],),
    );
    else
    return SpinKitSquareCircle(color: CupertinoColors.systemPurple,);
  }
}