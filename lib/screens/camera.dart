import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
// pdf Scanner . Top
// Globle Chat option . Top
// expand area on the pre tab region .
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File file;
  List<File> filelist = [];
  var picker = ImagePicker();
  var pdf = pw.Document();
  var image1;
  pdfFunc(file) {
    var image1 = PdfImage.file(
      pdf.document,
      bytes: file.readAsBytesSync(),
    );
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Image(image1);
      // Center
    }));
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00011f),
      appBar: AppBar(
        title: Text('Skilly Scanner'),
        backgroundColor: CupertinoColors.systemPurple,
        centerTitle: true,
      ),
      body: Center(
          child: Container(
        child: filelist.length > 0
            ? ListView.builder(itemBuilder: (context, index) {
                if (index < filelist.length) {
                  return Center(child:Image.file(
                    filelist[index],
                    height: 360,
                    width: 200,
                  ));
                } else if (index==filelist.length) {
                
                  return Center(child:Container(
                      height: 70,
                      width: 120,
                      margin: EdgeInsets.only(top: 30),
                      child: FlatButton.icon(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        padding: EdgeInsets.all(10),
                        onPressed: () async {
                          try {
                            Directory appDocDir =
                                await getApplicationDocumentsDirectory();
                            String appDocPath = appDocDir.path;
                            print(appDocDir);
                            String name;
                            var prefs = await SharedPreferences.getInstance();
                            if (!await prefs.containsKey('name')) {
                              await prefs.setString('name', 'yourfile1.pdf');
                              name = 'yourfile1.pdf';
                            } else {
                              name = await prefs.getString('name');
                              int val = int.parse(name[8]);
                              val++;
                              name = name.substring(0, 8) +
                                  val.toString() +
                                  '.pdf';
                              await prefs.setString('name', name);
                            }
                            var file1 = File('$appDocPath/$name');
                            print('$appDocPath/$name');
                            print('ok');

                            file1.writeAsBytesSync(pdf.save());
                            print('done');
                            Navigator.popAndPushNamed(context, '/PDF',
                                arguments: {
                                  'path': '$appDocPath/$name',
                                });
                          } catch (e) {
                            print(e);
                          }
                        },
                        icon: Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: CupertinoColors.systemPurple,
                      )));
                }
              })
            : Center(
                child: Text("Please Scan Your Document First!!!",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),

        // }) [
        //   file == null
        //       ? Center(
        //           child: Text('Please Scan Your Document First!!!',
        //               style: TextStyle(color: Colors.white, fontSize: 18)))
        //       : Image.file(
        //           file,
        //           height: 360,
        //           width: 200,
        //         ),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CupertinoColors.systemPurple,
        onPressed: () async {
          var packedfile = await picker.getImage(source: ImageSource.camera);
          var crop = await ImageCropper.cropImage(
              sourcePath: packedfile.path,
              compressQuality: 100,
              maxWidth: 700,
              maxHeight: 700,
              compressFormat: ImageCompressFormat.jpg,
              androidUiSettings: AndroidUiSettings(
                toolbarColor: CupertinoColors.systemPurple,
                toolbarTitle: "Skilly Cropper",
                statusBarColor: CupertinoColors.systemPurple,
                backgroundColor: Colors.grey,
                lockAspectRatio: false,
              ));

          setState(() {
            filelist.add(crop);

            pdfFunc(crop);
            print('yo');
          });
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}
