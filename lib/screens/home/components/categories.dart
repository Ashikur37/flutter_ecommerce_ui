import 'package:commerce/helper/auth.dart';
import 'package:commerce/screens/boucher/boucher_screen.dart';
import 'package:commerce/screens/categories/categories_screen.dart';
import 'package:commerce/screens/merchant/merchant_screen.dart';
import 'package:commerce/screens/offer/offer_screen.dart';
import 'package:commerce/screens/order/order_list.dart';
import 'package:commerce/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      // Categories, Door to Door, doddle Offer, prime Shop, Regular shop, order Boucher, Boucher shop, Doddle Ride,Doddle Food
      {
        "icon": "assets/icons/Categories.svg",
        "text": "Categories",
        "route": CategoriesScreen.routeName,
        'color': Colors.cyan,
      },
      {
        "icon": "assets/icons/Order.svg",
        "text": "Order",
        "route": OrderList.routeName,
        'color': Colors.amber.shade300,
      },
      {
        "icon": "assets/icons/Gift Icon.svg",
        "text": "Doddle Offer",
        "route": OfferScreen.routeName,
        'color': Colors.red.shade300,
      },
      {
        "icon": "assets/icons/store-solid.svg",
        "text": "Regular Shop",
        "route": MerchantScreen.routeName,
        'color': Colors.blue.shade300,
      },
      {
        "icon": "assets/icons/Door_to_door.svg",
        "text": "Door To Door",
        "route": BoucherScreen.routeName,
        'color': Colors.teal,
      },

      {
        "icon": "assets/icons/Prime_shop.svg",
        "text": "Prime Shop",
        "route": MerchantScreen.routeName,
        'color': Colors.purpleAccent,
      },

      {
        "icon": "assets/icons/Voucher.svg",
        "text": "Boucher",
        'color': Colors.green.shade300,
        "route": BoucherScreen.routeName
      },
      {
        "icon": "assets/icons/Voucher_Shop.svg",
        "text": "Boucher Shop",
        "route": BoucherScreen.routeName,
        'color': Colors.red,
      },
      {
        "icon": "assets/icons/biking-solid.svg",
        "text": "Doddle Ride",
        "route": BoucherScreen.routeName,
        'color': Color(0XFF0088ff),
      },
      {
        "icon": "assets/icons/Food.svg",
        "text": "Doddle Food",
        "route": BoucherScreen.routeName,
        'color': Colors.green,
      },
      {
        "icon": "assets/icons/truck-solid.svg",
        "text": "Doddle Courier",
        "route": BoucherScreen.routeName,
        'color': Color(0XFFf405b5),
      },
      // Doddle Ride,Doddle Food
    ];
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            categories.length,
            (index) => Row(
              children: [
                CategoryCard(
                  icon: categories[index]["icon"],
                  text: categories[index]["text"],
                  iconColor: categories[index]["color"],
                  press: () async {
                    if (index == 2) {
                      var login = await localIsLoggedIn();
                      if (!login) {
                        Navigator.pushNamed(
                          context,
                          SignInScreen.routeName,
                        );
                      } else {
                        Navigator.pushNamed(
                            context, categories[index]["route"]);
                      }
                    } else {
                      Navigator.pushNamed(context, categories[index]["route"]);
                    }
                  },
                ),
                SizedBox(
                  width: 5.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
    this.iconColor,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        // color: Colors.red,
        alignment: Alignment.center,
        width: getProportionateScreenWidth(67),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                // color: Color(0xFFebb2f7).withOpacity(0.2),
                color: Color(0X12AEB400),
                // color: Colors.blue,
                borderRadius: BorderRadius.circular(26),
              ),
              child: SvgPicture.asset(
                icon,
                // color: Color(0XFFD31AF8),
                color: iconColor,
              ),
            ),
            SizedBox(height: 5),
            Container(
              // color: Colors.red,
              // width: MediaQuery.of(context).size.width * 0.20,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0,
                  // fontWeight: FontWeight.00,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
