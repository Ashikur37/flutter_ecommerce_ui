import 'package:commerce/components/coustom_bottom_nav_bar.dart';
import 'package:commerce/constants.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';

class BoucherScreen extends StatefulWidget {
  static String routeName = "/boucher";
  @override
  _BoucherScreenState createState() => _BoucherScreenState();
}

class _BoucherScreenState extends State<BoucherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Boucher",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: Container(
        child: Center(
          child: Text(
            "Coming soon...",
            style: TextStyle(fontSize: 23.0, color: kPrimaryColor),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
