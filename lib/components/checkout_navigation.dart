import 'package:commerce/utilities/my_cart.dart';
import 'package:flutter/material.dart';

class CheckoutNavigation extends StatelessWidget {
  final Function placeOrder;

  const CheckoutNavigation({Key key, this.placeOrder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                      "BDT ${MyCart().cart.getTotalAmount()}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => placeOrder(),
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
