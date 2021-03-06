import 'package:flutter/material.dart';
import 'package:commerce/components/socal_card.dart';
import 'package:commerce/constants.dart';
import 'package:commerce/size_config.dart';

import 'sign_up_form.dart';

class Body extends StatelessWidget {
  final Function showMessage;

  const Body({Key key, this.showMessage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Register Account", style: headingStyle),
                Text(
                  "Complete your details",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignUpForm(showMessage: showMessage),
                SizedBox(height: SizeConfig.screenHeight * 0.08),

                Text(
                  'By continuing your confirm that you agree \nwith our Term and Condition',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
