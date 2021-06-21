import 'package:commerce/screens/boucher/boucher_screen.dart';
import 'package:commerce/screens/categories/categories_screen.dart';
import 'package:commerce/screens/merchant/merchant_screen.dart';
import 'package:commerce/screens/offer/offer_screen.dart';
import 'package:commerce/screens/order/order_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/icons/Flash Icon.svg",
        "text": "Bouchers",
        "route": BoucherScreen.routeName
      },
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
        "text": "Easymert Offer",
        "route": OfferScreen.routeName
      },
      {
        "icon": "assets/icons/Discover.svg",
        "text": "Shop",
        "route": MerchantScreen.routeName
      },
    ];
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            categories.length,
            (index) => Row(
              children: [
                CategoryCard(
                  icon: categories[index]["icon"],
                  text: categories[index]["text"],
                  press: () {
                    Navigator.pushNamed(context, categories[index]["route"]);
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
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon),
            ),
            SizedBox(height: 5),
            Text(text, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
