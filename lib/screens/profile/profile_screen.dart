import 'package:commerce/helper/auth.dart';
import 'package:flutter/material.dart';
import 'package:commerce/components/coustom_bottom_nav_bar.dart';
import 'package:commerce/enums.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
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
      // backgroundColor: Color(0XFFf7f8fa),
      // appBar: AppBar(
      //   title: Text("Profile"),
      // ),
      body: Body(
        showMessage: showMessage,
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
