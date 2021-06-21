import 'package:commerce/utilities/my_cart.dart';
import 'package:flutter/material.dart';

class CheckoutNavigation extends StatefulWidget {
  final Function placeOrder;

  const CheckoutNavigation({Key key, this.placeOrder}) : super(key: key);

  @override
  _CheckoutNavigationState createState() => _CheckoutNavigationState();
}

class _CheckoutNavigationState extends State<CheckoutNavigation> {
  var deliveryCharge = 0;
  @override
  void loadDelivery() {
    var charge = 0;
    for (var i = 0; i < MyCart().cart.cartItem.length; i++) {
      charge += MyCart().cart.cartItem[i].productDetails["product"]
          ["delivery_charge"];
    }
    setState(() {
      deliveryCharge = charge;
    });
    print(deliveryCharge);
  }

  @override
  Widget build(BuildContext context) {
    loadDelivery();
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
              Container(
                width: MediaQuery.of(context).size.width * 0.20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                  width: MediaQuery.of(context).size.width * 0.30,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                  ),
                  child: Text(
                    "Proceed to pay",
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
