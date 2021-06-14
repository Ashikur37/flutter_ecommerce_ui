import 'package:commerce/screens/campaign/campaign_screen.dart';
import 'package:commerce/screens/cart/cart_screen.dart';
import 'package:commerce/screens/sign_in/sign_in_screen.dart';
import 'package:commerce/screens/store/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:commerce/screens/home/home_screen.dart';
import 'package:commerce/screens/profile/profile_screen.dart';
import 'package:commerce/helper/auth.dart';
import '../constants.dart';
import '../enums.dart';

class CustomProductNavBar extends StatelessWidget {
  final Function addToCart;
  final productId;
  const CustomProductNavBar({Key key, this.addToCart, this.productId})
      : super(key: key);
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
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  StoreScreen.routeName,
                  arguments: StoreArguments(productId),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: Text(
                    "STORE",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.20,
                child: Text(
                  "CHAT",
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () => addToCart(false),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                  ),
                  child: Text(
                    "ADD TO CART",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => addToCart(true),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                  ),
                  child: Text(
                    "BUY NOW",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
