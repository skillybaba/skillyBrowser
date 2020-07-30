import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

List<String> ls = [];
var value;
SharedPreferences pref;
Future<void> getinsta() async {
  pref = await SharedPreferences.getInstance();
  if (!await pref.containsKey('history')) {
    await pref.setStringList('history', ls);
  }
}

delete(key) async {
  pref = await SharedPreferences.getInstance();
  await pref.setStringList(key, []);
  value = [];
  return true;
}

Future<bool> setvalue(value) async {
  pref = await SharedPreferences.getInstance();
  var val = await pref.getStringList('history');
  val.add(value);
  ls = val;
  await pref.setStringList('history', val);
  return true;
}

List ret() {
  return value;
}

Future<List<String>> getvalue(key) async {
  pref = await SharedPreferences.getInstance();
  List val = await pref.getStringList('history');

  value = val;
}
