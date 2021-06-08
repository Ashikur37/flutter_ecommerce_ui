import 'package:flutter/material.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    showMessage(String msg, Color color) {
      final snackBar = SnackBar(
        content: Text(msg),
        backgroundColor: color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Body(showMessage: showMessage),
    );
  }
}
