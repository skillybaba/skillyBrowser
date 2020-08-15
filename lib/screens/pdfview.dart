import 'package:flutter/cupertino.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:share_extend/share_extend.dart';

class PDFViewer extends StatefulWidget {
  @override
  _PDFViewerState createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  Map data;
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    return PDFViewerScaffold(
      path: data['path'],
      appBar: AppBar(
        actions: [
          FlatButton(
              onPressed: null,
              child: FlatButton.icon(
                  onPressed: () async {
                    try {
                      print(data['path']);
                      ShareExtend.share(data['path'], "file");
                    } catch (e) {
                      print(e);
                    }
                  },
                  icon: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Save Your PDF',
                    style: TextStyle(color: Colors.white),
                  )))
        ],
        title: Text('SB PDF'),
        backgroundColor: CupertinoColors.systemPurple,
      ),
    );
  }
}
