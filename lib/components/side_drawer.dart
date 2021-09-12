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
import 'package:flutter_svg/flutter_svg.dart';

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
            height: 240,
            child: DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Doddlemart',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "কেনাকাটা হরদম ",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "Doddlemart.com",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  isGuest
                      ? SizedBox()
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            avatar == null
                                ? SizedBox()
                                : Container(
                                    margin: EdgeInsets.only(top: 20),
                                    width: 70,
                                    height: 70,
                                    child: CircleAvatar(
                                      backgroundImage: avatar == null
                                          ? AssetImage(
                                              "assets/images/user.png",
                                            )
                                          : NetworkImage(
                                              "$rootUrl/images/user/$avatar"),
                                    ),
                                  ),
                            SizedBox(width: 10),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user["name"],
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    user["email"],
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                ],
              ),
              decoration: BoxDecoration(),
            ),
          ),
          ListTile(
            title: Row(children: [
              Container(
                width: 25,
                child: SvgPicture.asset(
                  'assets/icons/home-solid.svg',
                  color: Color(0XFF303030),
                  width: 20,
                ),
              ),
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
            title: Row(
              children: [
                // Icon(Icons.account_circle_outlined),
                Container(
                  width: 25,
                  child: SvgPicture.asset(
                    'assets/icons/tachometer-alt-solid.svg',
                    width: 24,
                  ),
                ),
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
              ],
            ),
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
              Container(
                width: 25,
                child: SvgPicture.asset(
                  'assets/icons/Order.svg',
                  width: 18,
                ),
              ),
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
              Container(
                width: 25,
                child: SvgPicture.asset(
                  "assets/icons/opencart.svg",
                  width: 20,
                  color: Color(0XFF303030),
                ),
              ),
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
              Container(
                width: 25,
                child: SvgPicture.asset(
                  'assets/icons/rocketchat.svg',
                  width: 24,
                ),
              ),
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
              Container(
                width: 25,
                child: SvgPicture.asset(
                  'assets/icons/phone-volume-solid.svg',
                  width: 20,
                ),
              ),
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
