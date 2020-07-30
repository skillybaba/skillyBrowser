import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';
import '../services/history.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  String urls =
      "https://www.google.com/webhp?hl=en&sa=X&ved=0ahUKEwjq8NaJie_qAhVRIbcAHSwAA2gQPAgH";
  TextEditingController controller = TextEditingController(text: 'https://');
  Map args;
  int index = 0;

  void setval(val) async {
    await getinsta();
    print(await setvalue(val));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    FlutterWebviewPlugin().dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double val;

    args = ModalRoute.of(context).settings.arguments;

    print(args);
    // FlutterWebviewPlugin().onProgressChanged.listen((event) {
    //   setState(() {
    //      val = event;
    //   });

    // });
    return WebviewScaffold(
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
              FlutterWebviewPlugin().reload();
            });
          } else {
            setState(() {
              FlutterWebviewPlugin()
                  .reloadUrl('https://www.google.com/search?-b-d&q=');
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
        // bottom: PreferredSize(
        //     child: LinearProgressIndicator(

        //       value: val,
        //     ),
        //     preferredSize: Size.fromHeight(10)),
        actions: <Widget>[
          RaisedButton(
              color: Colors.purple,
              onPressed: () {
                // setState(() {
                if (controller.text.length > 7) {
                  // if ((controller.text.substring(0, 8) != 'https://')&&(!controller.text.contains('.com'))) {
                  //   FlutterWebviewPlugin()
                  //       .reloadUrl('https://' + controller.text);
                  // }
                  if ((controller.text.contains('.com')) &&
                      (controller.text.substring(0, 8) != 'https://')) {
                    FlutterWebviewPlugin()
                        .reloadUrl('https://' + controller.text);

                    urls = 'https://' + controller.text;
                    setval(urls);
                  } else if ((controller.text.contains('.com')) &&
                      (controller.text.substring(0, 8) == 'https://')) {
                    FlutterWebviewPlugin().reloadUrl(controller.text);
                    urls = controller.text;
                    setval(urls);
                  } else {
                    FlutterWebviewPlugin().reloadUrl(
                        'https://www.google.com/search?-b-d&q=' +
                            controller.text);
                    urls = 'https://www.google.com/search?-b-d&q=' +
                        controller.text;
                    setval(urls);
                  }
                } else {
                  FlutterWebviewPlugin().reloadUrl(
                      'https://www.google.com/search?-b-d&q=' +
                          controller.text);
                  urls =
                      'https://www.google.com/search?-b-d&q=' + controller.text;
                  setval(urls);

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
              //   FlutterWebviewPlugin()
              //       .reloadUrl('https://' + controller.text);
              // }
              if ((controller.text.contains('.com')) &&
                  (controller.text.substring(0, 8) != 'https://')) {
                FlutterWebviewPlugin().reloadUrl('https://' + controller.text);
                urls = 'https://' + controller.text;
                setval(urls);
              } else if ((controller.text.contains('.com')) &&
                  (controller.text.substring(0, 8) == 'https://')) {
                FlutterWebviewPlugin().reloadUrl(controller.text);
                urls = controller.text;
                 setval(urls);
              } else {
                FlutterWebviewPlugin().reloadUrl(
                    'https://www.google.com/search?-b-d&q=' + controller.text);
                urls =
                    'https://www.google.com/search?-b-d&q=' + controller.text;
                     setval(urls);
              }
            } else {
              FlutterWebviewPlugin().reloadUrl(
                  'https://www.google.com/search?-b-d&q=' + controller.text);
              urls = 'https://www.google.com/search?-b-d&q=' + controller.text;
               setval(urls);
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
        backgroundColor: Colors.purple,
      ),
      url: args['url'],
    );
  }
}
