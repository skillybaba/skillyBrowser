import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/newservice.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<void> getnews() async {
    NewsService services = NewsService();
    await services.getNews();
    print(services.news);
    print(services.val);
    Navigator.popAndPushNamed(context, '/home',
        arguments: {'news': services.news});
  }

  @override
  Widget build(BuildContext context) {
    getnews();
    return Container(
        child: Center(child:  SpinKitSquareCircle(size:30,color:CupertinoColors.systemPurple)));
  }
}
