import 'package:commerce/constants.dart';
import 'package:commerce/helper/auth.dart';
import 'package:commerce/screens/cart/cart_screen.dart';
import 'package:commerce/screens/contact/contact_details.dart';
import 'package:commerce/screens/home/home_screen.dart';
import 'package:commerce/screens/login_success/login_success_screen.dart';
import 'package:commerce/screens/messagescreen/message_screen.dart';
import 'package:commerce/screens/order/order_list.dart';
import 'package:commerce/screens/profile/profile_screen.dart';
import 'package:commerce/screens/sign_in/sign_in_screen.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  var user;
  bool isLoading = true;
  bool isGuest = true;
  String avatar = null;
  _loadUser() async {
    var isLoggedIn = await localIsLoggedIn();
    if (isLoggedIn) {
      var data = await localGetUser();
      setState(() {
        isGuest = false;
        user = data;
        avatar = data["avatar"];
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      _loadUser();
    }
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 250,
            child: DrawerHeader(
              child: Column(
                children: [
                  Text(
                    'Doddlemart',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "কেনাকাটা হরদম ",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Doddlemart.com",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  isGuest
                      ? SizedBox()
                      : Column(
                          children: [
                            avatar == null
                                ? SizedBox()
                                : CircleAvatar(
                                    backgroundImage: avatar == null
                                        ? AssetImage("assets/images/user.png")
                                        : NetworkImage(
                                            "$rootUrl/images/user/$avatar"),
                                  ),
                            Text(
                              user["name"],
                            ),
                            Text(
                              user["email"],
                            ),
                          ],
                        )
                ],
              ),
              decoration: BoxDecoration(),
            ),
          ),
          ListTile(
            title: Row(children: [
              Icon(Icons.home_outlined),
              SizedBox(
                width: 10,
              ),
              Text(
                'Home',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ]),
            onTap: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
          ),
          ListTile(
            title: Row(children: [
              Icon(Icons.account_circle_outlined),
              SizedBox(
                width: 10,
              ),
              Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ]),
            onTap: () async {
              var isLoggedIn = await localIsLoggedIn();
              if (isLoggedIn) {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              } else {
                Navigator.pushNamed(context, SignInScreen.routeName);
              }
            },
          ),
          ListTile(
            title: Row(children: [
              Icon(Icons.shopping_bag_outlined),
              SizedBox(
                width: 10,
              ),
              Text(
                'My Order',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ]),
            onTap: () async {
              var login = await localIsLoggedIn();
              if (!login) {
                Navigator.pushNamed(
                  context,
                  SignInScreen.routeName,
                );
              } else {
                Navigator.popAndPushNamed(context, OrderList.routeName);
              }
            },
          ),
          ListTile(
            title: Row(children: [
              Icon(Icons.shopping_cart_outlined),
              SizedBox(
                width: 10,
              ),
              Text(
                'Cart',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ]),
            onTap: () {
              Navigator.popAndPushNamed(context, CartScreen.routeName);
            },
          ),
          ListTile(
            title: Row(children: [
              Icon(Icons.message),
              SizedBox(
                width: 10,
              ),
              Text(
                'Inbox',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ]),
            onTap: () async {
              var login = await localIsLoggedIn();
              if (!login) {
                Navigator.pushNamed(
                  context,
                  SignInScreen.routeName,
                );
              } else {
                Navigator.popAndPushNamed(context, MessageScreen.routeName);
              }
            },
          ),
          ListTile(
            title: Row(children: [
              Icon(Icons.contact_support_sharp),
              SizedBox(
                width: 10,
              ),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ]),
            onTap: () {
              Navigator.popAndPushNamed(context, ContactDetails.routeName);
            },
          ),
        ],
      ),
    );
  }
}
