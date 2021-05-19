import 'package:http/http.dart';
import 'dart:convert';

class NewsService {
  bool val;
  var news;
  Future<void> getNews() async {
    try {
      Response res = await get(
          "https://skillybaba.pythonanywhere.com/skillybrowserapi/news/?format=json");
      news = jsonDecode(res.body);
      print(news);
      print('done');
      val = true;
    } catch (e) {
      print(e);
      val = false;
    }
  }
}
