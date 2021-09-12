import 'package:commerce/screens/campaign/campaign_screen.dart';
import 'package:commerce/screens/cart/cart_screen.dart';
import 'package:commerce/screens/sign_in/sign_in_screen.dart';
import 'package:commerce/screens/wishlist/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:commerce/screens/home/home_screen.dart';
import 'package:commerce/screens/profile/profile_screen.dart';
import 'package:commerce/helper/auth.dart';
import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      "assets/icons/home-solid.svg",
                      color: MenuState.home == selectedMenu
                          ? kPrimaryColor
                          : inActiveIconColor,
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, HomeScreen.routeName),
                  ),
                  Text("Home")
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: SvgPicture.asset("assets/icons/heart.svg"),
                    onPressed: () {
                      Navigator.pushNamed(context, WishListsScreen.routeName);
                    },
                  ),
                  Text("wishlist")
                ],
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        // "assets/icons/campaign.svg",
                        'assets/icons/bullhorn-solid.svg',
                        color: kPrimaryColor,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, CampaignScreen.routeName);
                      },
                    ),
                    Text("Campaign")
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: SvgPicture.asset("assets/icons/opencart.svg"),
                    onPressed: () {
                      Navigator.pushNamed(context, CartScreen.routeName);
                    },
                  ),
                  Text("Cart")
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/User Icon.svg",
                        color: MenuState.profile == selectedMenu
                            ? kPrimaryColor
                            : inActiveIconColor,
                      ),
                      onPressed: () async {
                        var isLoggedIn = await localIsLoggedIn();
                        print(isLoggedIn);
                        if (isLoggedIn) {
                          Navigator.pushNamed(context, ProfileScreen.routeName);
                        } else {
                          Navigator.pushNamed(context, SignInScreen.routeName);
                        }
                      }),
                  Text("Account")
                ],
              ),
            ],
          )),
    );
  }
}
