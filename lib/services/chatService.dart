import "../models/user.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

class ChatService
{
  User user;

  ChatService({this.user});
  static getImages({var color,var backgroundcolor,type="camera"}) async{
   var image = ImagePicker();
   var file = await image.getImage(source: type=="camera"?ImageSource.camera:ImageSource.gallery);
   var crop  = await ImageCropper.cropImage(sourcePath: file.path, compressQuality: 100,
              maxWidth: 700,
              maxHeight: 700,
              compressFormat: ImageCompressFormat.jpg,
              androidUiSettings: AndroidUiSettings(
                toolbarColor: color,
                toolbarTitle: "Skilly Cropper",
                statusBarColor: color,
                backgroundColor: backgroundcolor,
                lockAspectRatio: false,
              ));
    return crop;

  }
 addMessage(text,[image]) async
 {
   await Firebase.initializeApp();
   FirebaseFirestore firestore = FirebaseFirestore.instance;
   var collection = firestore.collection('message');
   if(image!=null)
   {
     FirebaseStorage storage = FirebaseStorage.instance;
     var ref = storage.ref().child("images/${user.number+DateTime.now().toString()}");
     var uploadref =ref.putFile(image);
     var upload = await uploadref.onComplete;
     image = await upload.ref.getDownloadURL();

   }
  await  collection.add({
     "text":text,
     "image":image,
     "datetime":DateTime.now(),
     "user":{
       "name":user.name,
       "number":user.number,
       "avatar":user.dp,
       "docid":user.docid,
     }
   });
 }
  
}