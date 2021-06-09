import 'package:commerce/helper/auth.dart';
import 'package:commerce/screens/address/address_list.dart';
import 'package:commerce/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Basic Info",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Address",
            icon: "assets/icons/Bell.svg",
            press: () {
              Navigator.pushNamed(context, AddressList.routeName);
            },
          ),
          ProfileMenu(
            text: "Change Password",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Order History",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Message",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              await localLogout();
              Navigator.popAndPushNamed(context, SignInScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
