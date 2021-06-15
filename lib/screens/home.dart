import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import './subscreens/pretabs.dart';
import './subscreens/animatedfloating.dart';
import './subscreens/urlbox.dart';
import './subscreens/newssubs.dart';
import 'package:skillybrowser/constant_lists.dart';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:native_state/native_state.dart';


class Home extends StatefulWidget {
  final SavedStateData savedState;
  final bool restoredFromState;

  Home({this.savedState})
      : this.restoredFromState = savedState.getBool("saved") {
    savedState.putBool("saved", true);
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var news;
  final GlobalKey<ScaffoldState> state = GlobalKey<ScaffoldState>();

  //image picker functions:
  String pickedImagePath; //contains the path of picked image by the image_picker
  File _image;
  final picker = ImagePicker();

  //1. function for taking photo clicked (by camera) :-
  Future get_Image_From_Camera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        pickedImagePath = pickedFile.path;
        _image = File(pickedImagePath);
        SavedState.of(context).putString("imagePath", pickedImagePath);
      }
      else {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context){
            return AlertDialog(
              title: const Text('No Image Selected'),
            );
          },
        );
      }
    });
  }

  //1. function for taking photo from gallery :-
  Future get_Image_From_Gallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        pickedImagePath = pickedFile.path;
        _image = File(pickedImagePath);
        SavedState.of(context).putString("imagePath", pickedImagePath);
      }
      else {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context){
            return AlertDialog(
              title: const Text('No Image Selected'),
            );
          }
        );
      }
    });
  }

  //method for getting the saved minimal state after app is killed:-
  @override
  void restoreState(SavedStateData savedState) {
    debugPrint("restoreState");
    setState(() {
      pickedImagePath = savedState.getString("imagePath") ?? null;
    });
  }

  //Method for showing AlertDialog Box (for selecting camera or gallery):-
  Future<void> _show_Select_Wallpaper_Dialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Home Screen Wallpaper'),
          actions: <Widget>[
            TextButton(
              child: const Text('Click a Photo'),
              onPressed: () async{
                await get_Image_From_Camera();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Select From Gallery'),
              onPressed: () async{
                await get_Image_From_Gallery();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Remove Wallpaper'),
              onPressed: () {
                setState(() {
                  _image = null;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[

                    Expanded(
                      flex: 1,
                      child: Container(
                        color: CupertinoColors.systemPurple,
                        padding: EdgeInsets.only(
                            top: 100, bottom: 4, left: 71, right: 71),
                        child: Text(
                          'Skilly Browser',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25),
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 5,
                      child: Container(
                        child: AnimationLimiter(
                          child: ListView.builder(
                            itemCount: title_list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: (index < title_list.length-1) ?
                                    ListTile(
                                      leading: Icon(
                                        listTile_icons[index],
                                        color: Colors.white,
                                      ),
                                      onTap: () {
                                        Navigator.pushNamed(context, next_root[index]);
                                      },
                                      subtitle: Text(
                                        subtitle_list[index],
                                        style: TextStyle(color: CupertinoColors.white),
                                      ),
                                      title: Text(
                                        title_list[index],
                                        style:
                                        TextStyle(fontSize: 20, color: CupertinoColors.white),
                                      ),
                                    )
                                        :
                                    ListTile(
                                      leading: Icon(
                                        listTile_icons[index],
                                        color: Colors.white,
                                      ),
                                      onTap: () {
                                        //show alert dialog box:
                                        _show_Select_Wallpaper_Dialog();
                                      },
                                      subtitle: Text(
                                        subtitle_list[index],
                                        style: TextStyle(color: CupertinoColors.white),
                                      ),
                                      title: Text(
                                        title_list[index],
                                        style:
                                        TextStyle(fontSize: 20, color: CupertinoColors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
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

            backgroundColor: Colors.transparent, //Color(0xff00011f),
            appBar: AppBar(
              actions: [
             
                IconButton(
                  icon: Icon(Icons.camera),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,'/Camera'
                    );
                  },
                ),  
                 SizedBox(
                  width: 8,
                ),
              ],
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
                  Icons.menu,
                  color: Colors.white,
                )),
              ),
            ),

            body: Stack(
              children: <Widget>[
                Opacity(
                  opacity: 0.7,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: (_image != null) ?
                    Image.file(
                        _image,
                        height: 100,
                        width: 100,
                      fit: BoxFit.cover,
                    ) :
                    null,
                  ),
                ),

                Container(
                child: SingleChildScrollView(
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
                      NewsSub(news: news['news'] , backGroundColor: (_image != null) ? Colors.transparent : Color(0xff040523),),
                    ],
                  ),
                ),
              ),
            ],),
            floatingActionButton: Animatedfloating(news: news['news'])));
  }
}
