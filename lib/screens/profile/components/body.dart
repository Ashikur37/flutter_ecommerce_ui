import 'package:commerce/helper/auth.dart';
import 'package:commerce/screens/address/address_list.dart';
import 'package:commerce/screens/change_password/change_password.dart';
import 'package:commerce/screens/messagescreen/message_screen.dart';
import 'package:commerce/screens/order/order_list.dart';
import 'package:commerce/screens/profile/components/basic.dart';
import 'package:commerce/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  final Function showMessage;

  const Body({Key key, this.showMessage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(showMessage: showMessage),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Basic Info",
            icon: "assets/icons/user-tie-solid.svg",
            press: () => {Navigator.pushNamed(context, BasicProfile.routeName)},
          ),
          ProfileMenu(
            text: "Address",
            icon: "assets/icons/map-marker-solid.svg",
            press: () {
              Navigator.pushNamed(context, AddressList.routeName);
            },
          ),
          ProfileMenu(
            text: "Change Password",
            icon: "assets/icons/key-solid.svg",
            press: () {
              Navigator.pushNamed(context, ChangePassword.routeName);
            },
          ),
          ProfileMenu(
            text: "Order History",
            icon: "assets/icons/history-solid.svg",
            press: () {
              Navigator.pushNamed(context, OrderList.routeName);
            },
          ),
          ProfileMenu(
            text: "Message",
            icon: "assets/icons/rocketchat.svg",
            press: () {
              Navigator.pushNamed(context, MessageScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/sign-out-alt-solid.svg",
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
