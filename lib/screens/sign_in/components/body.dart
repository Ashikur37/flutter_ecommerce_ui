import 'package:commerce/components/No_account_text.dart';
import 'package:commerce/components/custom_suffix_icon.dart';
import 'package:commerce/components/default_button.dart';
import 'package:commerce/components/form_error.dart';
import 'package:commerce/components/social_card.dart';
import 'package:commerce/constants.dart';
import 'package:commerce/screens/forget_password/forget_password_screen.dart';
import 'package:commerce/screens/sign_in/components/sign_in_form.dart';
import 'package:commerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Text(
                  "Welcome back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in with your email and password \nor continue with social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.08,
                ),
                SigninForm(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.08,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {
                        print("me");
                      },
                    ),
                    SocialCard(
                      icon: "assets/icons/facebook-2.svg",
                    ),
                    SocialCard(
                      icon: "assets/icons/twitter.svg",
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                NoAccountText()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
