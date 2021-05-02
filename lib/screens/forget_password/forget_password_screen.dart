import 'package:flutter/material.dart';
import '../forget_password/components/body.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static String routeName = "/forget_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot password"),
      ),
      body: Body(),
    );
  }
}
