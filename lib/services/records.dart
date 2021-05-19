import 'package:http/http.dart';
import 'dart:convert';

addrecord({String st}) async {
  try {
    if ((st.contains('https://')) ||
        (st.contains('.com')) ||
        (st.contains('www.'))) {
      // st = st.substring(7, st.length - 4);
      st = st.replaceAll('www.', '');
      st = st.replaceAll('https://', '');
      st = st.replaceAll('.com', '');
      print(st);
    }

    // if (st.contains('www.')) {
    //   st = st.substring(13, st.length - 5);
    // }
    Response res = await get(
        'https://skillybaba.pythonanywhere.com/skillybrowserapi/recordsgo/' +
            st);
    print(jsonDecode(res.body));

    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
