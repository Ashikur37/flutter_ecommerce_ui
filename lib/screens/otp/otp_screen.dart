import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/sign_in/sign_in_screen.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:commerce/size_config.dart';

import 'components/body.dart';

class OtpScreen extends StatefulWidget {
  static String routeName = "/otp";

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int attempt = 0;
  @override
  Widget build(BuildContext context) {
    final OtpArguments agrs = ModalRoute.of(context).settings.arguments;
    print(agrs.firstName);
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Body(
        phone: agrs.phone,
        submitReg: (var otp) async {
          setState(() {
            attempt++;
          });
          if (attempt < 5) {
            var data = await postHttp("$baseUrl$registerUrl", {
              "firstname": agrs.firstName,
              "lastname": agrs.lastName,
              "mobile": agrs.phone,
              "password": agrs.password,
              "otp": otp
            });
            if (!data["success"]) {
              final snackBar = SnackBar(
                content: Text(data["message"]),
                backgroundColor: Colors.redAccent,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              final snackBar = SnackBar(
                content: Text("Account created successfully"),
                backgroundColor: Colors.greenAccent,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.popAndPushNamed(context, SignInScreen.routeName);
            }
          } else {
            final snackBar = SnackBar(
              content: Text("Too many attempt.Try again later"),
              backgroundColor: Colors.redAccent,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
      ),
    );
  }
}

class OtpArguments {
  final firstName;
  final lastName;
  final phone;
  final password;

  OtpArguments(this.firstName, this.lastName, this.phone, this.password);
}
