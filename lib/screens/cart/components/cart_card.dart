import 'package:commerce/components/rounded_icon_btn.dart';
import 'package:commerce/utilities/const.dart';
import 'package:commerce/utilities/my_cart.dart';
import 'package:flutter/material.dart';
import 'package:commerce/models/Cart.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key key,
    @required this.cart,
    this.increment,
    this.decrement,
  }) : super(key: key);
  final Function increment;
  final Function decrement;

  final cart;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network("$rootUrl/images/product/" +
                  cart.productDetails["product"]["image"]),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.productDetails["product"]["name"],
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            Row(
              children: [
                cart.productDetails["colorIndex"] == -1
                    ? SizedBox()
                    : Container(
                        margin: EdgeInsets.only(right: 2),
                        padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                        height: getProportionateScreenWidth(40),
                        width: getProportionateScreenWidth(40),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: HexColor(cart.productDetails["product"]
                                        ["colors"]
                                    [cart.productDetails["colorIndex"]]["color"]
                                ["code"]),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                cart.productDetails["sizeIndex"] == -1
                    ? SizedBox()
                    : Text(cart.productDetails["product"]["sizes"]
                        [cart.productDetails["sizeIndex"]]["size"]["name"])
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    text: "৳${cart.unitPrice}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                    children: [
                      TextSpan(
                          text: " x${cart.quantity}",
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                ),
                RoundedIconBtn(
                  icon: Icons.remove,
                  press: () {
                    decrement();
                  },
                ),
                SizedBox(
                  width: getProportionateScreenWidth(20),
                  child: Text(cart.quantity.toString()),
                ),
                RoundedIconBtn(
                  icon: Icons.add,
                  showShadow: true,
                  press: () {
                    increment();
                  },
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
