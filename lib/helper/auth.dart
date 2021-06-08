import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

localLogin(user, token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('loggedin', true);
  prefs.setString('user', jsonEncode(user));
  prefs.setString('token', token);
}

localLogout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('loggedin', false);
  prefs.setString('user', "");
  prefs.setString('token', "");
}

localGetUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return jsonDecode(prefs.getString('user'));
}

localGetToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

localIsLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('loggedin');
}
