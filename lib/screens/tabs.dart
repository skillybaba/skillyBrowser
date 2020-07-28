import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  String urls =
      "https://www.google.com/webhp?hl=en&sa=X&ved=0ahUKEwjq8NaJie_qAhVRIbcAHSwAA2gQPAgH";
  TextEditingController controller = TextEditingController(text: 'https://');
  Map args;
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    print(args);
    return WebviewScaffold(
      enableAppScheme: true,
      geolocationEnabled: true,
      displayZoomControls: true,
      mediaPlaybackRequiresUserGesture: true,
      withJavascript: true,
      withLocalStorage: true,
      withLocalUrl: true,
      
      useWideViewPort: true,
      withOverviewMode: true,
      withZoom: true,
      scrollBar: true,
      supportMultipleWindows: true,
      appBar: AppBar(
        actions: <Widget>[
          RaisedButton(
              color: Colors.purple,
              onPressed: () {
                setState(() {
                  if (controller.text.length > 7) {
                    // if ((controller.text.substring(0, 8) != 'https://')&&(!controller.text.contains('.com'))) {
                    //   FlutterWebviewPlugin()
                    //       .reloadUrl('https://' + controller.text);
                    // }
                    if ((controller.text.contains('.com'))&&(controller.text.substring(0, 8) != 'https://')) {
                    FlutterWebviewPlugin().reloadUrl('https://'+controller.text);
                  }
                   else if ((controller.text.contains('.com'))&&(controller.text.substring(0, 8) == 'https://')) {
                    FlutterWebviewPlugin().reloadUrl(controller.text);
                  }
                  else {
                    FlutterWebviewPlugin().reloadUrl(
                        'https://www.google.com/search?-b-d&q=' +
                            controller.text);
                  }
                  } 
                  else {
                    FlutterWebviewPlugin().reloadUrl(
                        'https://www.google.com/search?-b-d&q=' +
                            controller.text);
                  }
                   
                });
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
                    if ((controller.text.contains('.com'))&&(controller.text.substring(0, 8) != 'https://')) {
                    FlutterWebviewPlugin().reloadUrl('https://'+controller.text);
                  }
                   else if ((controller.text.contains('.com'))&&(controller.text.substring(0, 8) == 'https://')) {
                    FlutterWebviewPlugin().reloadUrl(controller.text);
                  }
                  else {
                    FlutterWebviewPlugin().reloadUrl(
                        'https://www.google.com/search?-b-d&q=' +
                            controller.text);
                  }
                  } 
                  else {
                    FlutterWebviewPlugin().reloadUrl(
                        'https://www.google.com/search?-b-d&q=' +
                            controller.text);
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
