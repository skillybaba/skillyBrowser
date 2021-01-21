import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import './subscreens/pretabs.dart';
import './subscreens/animatedfloating.dart';
import './subscreens/urlbox.dart';
import './subscreens/newssubs.dart';
import '../services/history.dart';
import 'package:animated_widgets/animated_widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var news;
  final GlobalKey<ScaffoldState> state = GlobalKey<ScaffoldState>();

  TextEditingController url = TextEditingController();
  @override
  Widget build(BuildContext context) {
    news = ModalRoute.of(context).settings.arguments;
    
    return TranslationAnimatedWidget(
        enabled: true, //update this boolean to forward/reverse the animation
        values: [
          Offset(0, 20), // disabled value value
          Offset(0, 25), //intermediate value
          Offset(0, 0) //enabled value
        ],
        child: Scaffold(
          
            key: state,
            drawer: Drawer(
                child: Container(
                  color: Color(0xff00011f),
            
              child: ListView(
                children: [
                  Container(
                   
                    child: DrawerHeader(
                        decoration: BoxDecoration(
                          
                          color: CupertinoColors.systemPurple,
                        ),
                        padding: EdgeInsets.only(
                            top: 100, bottom: 4,left: 71,right: 71 ),
                        child: Text(
                          'Skilly Browser',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25),
                        )),
                  ),
                 
                ListTile(
                  
                  leading: Icon(Icons.camera,color: Colors.white,),
                    onTap: () {
                      Navigator.pushNamed(context, '/Camera');
                    },
                  subtitle: Text("Make Pdfs",style: TextStyle(
                           color: CupertinoColors.white),),
                    title: Text(
                      "Skilly Scanner",
                      style: TextStyle(
                          fontSize: 20, color: CupertinoColors.white),
                    ),
                  ),
                  ListTile(leading: Hero(child: Icon(Icons.meeting_room,color: Colors.white,),tag: "Conf",),title: Text("Skilly Meet",style:TextStyle(
                          fontSize: 20, color: CupertinoColors.white),
                    ),subtitle: Text("Group Conference calling",style: TextStyle(
                           color: CupertinoColors.white) ,),onTap: (){
                    Navigator.pushNamed(context, "/Conference");
                  },),
               ListTile(
                 leading: Icon(Icons.policy,color:Colors.white),
                    onTap: () {
                      Navigator.pushNamed(context, '/Privacy');
                    },
                  subtitle: Text("Our Policy",style: TextStyle(
                           color: CupertinoColors.white),),
                    title: Text(
                      "Privacy Policy",
                      style: TextStyle(
                          fontSize: 20, color: CupertinoColors.white),
                    ),
                  ),
                   
                ListTile(
                  leading: Icon(Icons.pageview,color: Colors.white,),
                    onTap: () {
                      Navigator.pushNamed(context, '/AboutUs');
                    },
                   subtitle: Text("About our Applicaiton",style: TextStyle(
                           color: CupertinoColors.white),),
                    title: Text(
                      "About Us",
                      style: TextStyle(
                          fontSize: 20, color: CupertinoColors.white),
                    ),
                  ),
                 
                ],
              ),
            )),
            //     child: FlatButton.icon(
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/Camera');
            //   },
            //   icon: Icon(Icons.camera),
            //   label: Text("Skilly Scanner"),
            // )),

            backgroundColor: Color(0xff00011f),
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              title: Text(
                'SKILLY BROWSER',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: CupertinoColors.systemPurple,
              centerTitle: true,
              leading: FlatButton(
                onPressed: () {
                  state.currentState.openDrawer();
                },
                child: Container(
                    child: Icon(
                  Icons.table_chart,
                  color: Colors.white,
                )),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 9,
                  ),
                  Pretabs(),
                  Urlbox(),
                  SizedBox(
                    height: 10,
                  ),
                  NewsSub(news: news['news']),
                ],
              ),
            ),
            floatingActionButton: Animatedfloating(news: news['news'])));
  }
}
