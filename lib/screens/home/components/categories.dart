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
        "icon": "assets/icons/Bill Icon.svg",
        "text": "Categories",
        "route": CategoriesScreen.routeName
      },
      {
        "icon": "assets/icons/Game Icon.svg",
        "text": "Order",
        "route": OrderList.routeName
      },
      {
        "icon": "assets/icons/Gift Icon.svg",
        "text": "Doddle Offer",
        "route": OfferScreen.routeName
      },
      {
        "icon": "assets/icons/Discover.svg",
        "text": "Regular Shop",
        "route": MerchantScreen.routeName
      },
      {
        "icon": "assets/icons/Flash Icon.svg",
        "text": "Door To Door",
        "route": BoucherScreen.routeName
      },

      {
        "icon": "assets/icons/Discover.svg",
        "text": "Prime Shop",
        "route": MerchantScreen.routeName
      },

      {
        "icon": "assets/icons/Flash Icon.svg",
        "text": "Boucher",
        "route": BoucherScreen.routeName
      },
      {
        "icon": "assets/icons/Flash Icon.svg",
        "text": "Boucher Shop",
        "route": BoucherScreen.routeName
      },
      {
        "icon": "assets/icons/Flash Icon.svg",
        "text": "Doddle Ride",
        "route": BoucherScreen.routeName
      },
      {
        "icon": "assets/icons/Flash Icon.svg",
        "text": "Doddle Food",
        "route": BoucherScreen.routeName
      },
      {
        "icon": "assets/icons/Flash Icon.svg",
        "text": "Doddle Courier",
        "route": BoucherScreen.routeName
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
                  width: 10.0,
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
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        // color: Colors.red,
        width: getProportionateScreenWidth(70),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFebb2f7).withOpacity(0.2),
                // color: Colors.blue,
                borderRadius: BorderRadius.circular(26),
              ),
              child: SvgPicture.asset(
                icon,
                color: Color(0XFFD31AF8),
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
