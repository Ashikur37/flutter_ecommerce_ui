import 'package:commerce/constants.dart';
import 'package:commerce/utilities/my_cart.dart';
import 'package:flutter/material.dart';

class CheckoutNavigation extends StatefulWidget {
  final Function placeOrder;
  final String region;
  final bool addressLoading;
  const CheckoutNavigation(
      {Key key, this.placeOrder, this.region, this.addressLoading})
      : super(key: key);

  @override
  _CheckoutNavigationState createState() => _CheckoutNavigationState();
}

class _CheckoutNavigationState extends State<CheckoutNavigation> {
  var deliveryCharge = 0;

  @override
  void loadDelivery() {
    var charge = 0;
    for (var i = 0; i < MyCart().cart.cartItem.length; i++) {
      // print(MyCart().cart.cartItem[i].productDetails["product"][widget.region]);
      if (MyCart().cart.cartItem[i].productDetails["product"][widget.region] !=
          null) {
        charge += int.parse(MyCart()
            .cart
            .cartItem[i]
            .productDetails["product"][widget.region]
            .toString());
      }
    }
    setState(() {
      deliveryCharge = charge;
    });
  }

  @override
  Widget build(BuildContext context) {
    loadDelivery();
    return Container(
      margin: EdgeInsets.only(
        bottom: 10,
      ),
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
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Pay",
                      ),
                      Text(
                        "BDT ${MyCart().cart.getTotalAmount() + deliveryCharge}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => widget.placeOrder(),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Process to Order",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
