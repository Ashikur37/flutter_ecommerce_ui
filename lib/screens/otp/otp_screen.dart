import 'package:flutter/material.dart';
import 'package:commerce/size_config.dart';

import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
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
