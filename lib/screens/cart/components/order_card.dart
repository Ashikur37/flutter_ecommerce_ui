import 'package:commerce/helper/auth.dart';
import 'package:commerce/screens/checkout/checkout_screen.dart';
import 'package:commerce/screens/sign_in/sign_in_screen.dart';
import 'package:commerce/utilities/my_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:commerce/components/default_button.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class OrderCard extends StatelessWidget {
  final total;
  const OrderCard({
    Key key,
    this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "৳" + total,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    color: Colors.redAccent,
                    child: Text(
                      "Cash on delivery",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    color: Colors.redAccent,
                    child: Text(
                      "Pay Now",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
