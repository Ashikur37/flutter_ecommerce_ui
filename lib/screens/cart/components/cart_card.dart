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
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.35,
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                decoration: BoxDecoration(
                  // color: Color(0xFFf7f),
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
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  cart.productDetails["product"]["name"],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  maxLines: 2,
                ),
              ),
              Row(
                children: [
                  cart.productDetails["colorIndex"] == -1
                      ? SizedBox()
                      : Container(
                          margin: EdgeInsets.only(right: 2),
                          padding:
                              EdgeInsets.all(getProportionateScreenWidth(8)),
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
                                      [cart.productDetails["colorIndex"]]
                                  ["color"]["code"]),
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
              Container(
                // color: Colors.red,
                // width: double.infinity,
                width: MediaQuery.of(context).size.width * 0.63,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text.rich(
                        TextSpan(
                          text: "৳${cart.unitPrice}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor),
                          children: [
                            TextSpan(
                                text: " x${cart.quantity}",
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        children: [
                          RoundedIconBtn(
                            showShadow: true,
                            icon: Icons.remove,
                            press: () {
                              decrement();
                            },
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(30),
                            child: Text(
                              cart.quantity.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          RoundedIconBtn(
                            icon: Icons.add,
                            showShadow: true,
                            press: () {
                              increment();
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
