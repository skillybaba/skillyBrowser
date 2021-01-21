import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import './firebase.dart';
class ConferenceService
{
  String roomid;
  String name;
  String number;
  String docid;
  ConferenceService({this.roomid,this.name,this.number,this.docid});
  hostMeeting([type='host']) async
  {
    var options = JitsiMeetingOptions();
    if((type=="join")&&(!await FirebaseService.checkRoom(this.roomid)))
    {
      return false;
    }
    options.room=this.roomid;
    options.userDisplayName=name;
    options.featureFlags.addAll({FeatureFlagEnum.INVITE_ENABLED:false});
    if(type!="rejoin")
    FirebaseService.meetingStore(roomid: this.roomid,hostdocid: this.docid,hostnumber: this.number);
    JitsiMeet.joinMeeting(options);
    return true;
  }
  
}