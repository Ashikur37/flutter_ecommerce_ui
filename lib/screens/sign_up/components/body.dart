import 'package:commerce/components/social_card.dart';
import 'package:commerce/constants.dart';
import 'package:commerce/screens/sign_up/components/signup_form.dart';
import 'package:commerce/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.03,
              ),
              Text(
                "Register Account",
                style: headingStyle,
              ),
              Text(
                "Complete your details or continue \nwith social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.08,
              ),
              SizedBox(
                height: 10,
              ),
              SignupForm(),
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
              Text(
                "By continuing your confirmthat you agree \n with our Term and Condition",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
