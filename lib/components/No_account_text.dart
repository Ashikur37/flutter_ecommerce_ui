import 'package:commerce/constants.dart';
import 'package:commerce/screens/forget_password/forget_password_screen.dart';
import 'package:commerce/screens/sign_up/signup_screen.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(16),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            SignUpScreen.routeName,
          ),
          child: Text(
            "Sign up",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(16),
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
