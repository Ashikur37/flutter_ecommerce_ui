import 'package:commerce/components/coustom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';

class OfferScreen extends StatefulWidget {
  static String routeName = "/offer";
  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offer"),
      ),
      body: Container(
        child: Center(
          child: Text(
            "Coming soon...",
            style: TextStyle(fontSize: 23.0, color: Colors.redAccent),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
