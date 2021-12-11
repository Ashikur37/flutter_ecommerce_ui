import 'package:commerce/components/coustom_bottom_nav_bar.dart';
import 'package:commerce/components/side_drawer.dart';
import 'package:commerce/constants.dart';
import 'package:commerce/enums.dart';
import 'package:flutter/material.dart';

class ContactDetails extends StatefulWidget {
  static String routeName = "/contact_details";

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text("Contact Us"),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Text(
            "easymartshopping",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text("84/A/B 2nd clony,"),
          Text(" Mazar Road,"),
          Text("Mirpur-1,Dhaka-1216"),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email),
              SizedBox(
                width: 1,
              ),
              Column(
                children: [
                  Text("info@easymartshopping.com"),
                  Container(
                    margin: EdgeInsets.only(left: 19),
                    child: Text("support@easymartshopping.com"),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.call),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Text("01407090450"),
                  Container(
                    child: Text("01407090451"),
                  ),
                ],
              ),
            ],
          )

// CALL US
// 01407090450
// 01407090451
        ]),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
