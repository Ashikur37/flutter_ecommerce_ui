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

localSetUser(user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('user', jsonEncode(user));
}

updateAvatar(String avatar) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var user = jsonDecode(prefs.getString('user'));
  user["avatar"] = avatar;
  prefs.setString('user', jsonEncode(user));
}

localGetToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

localIsLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('loggedin') == null) {
    return false;
  }
  return prefs.getBool('loggedin');
}
