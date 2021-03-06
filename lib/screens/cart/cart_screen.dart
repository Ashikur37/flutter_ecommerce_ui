import 'package:commerce/constants.dart';
import 'package:commerce/models/Cart.dart';
import 'package:commerce/test.dart';
import 'package:commerce/utilities/my_cart.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var myCart = MyCart();
  @override
  Widget build(BuildContext context) {
    showMessage(String msg, Color color) {
      final snackBar = SnackBar(
        content: Text(msg),
        backgroundColor: color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Scaffold(
      backgroundColor: Color(0XFFf7f8fa),
      appBar: buildAppBar(context),
      body: Body(
        updateCart: () {
          setState(() {
            myCart = MyCart();
          });
        },
      ),
      bottomNavigationBar: CheckoutCard(
        showMessage: showMessage,
        myCart: myCart,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: kPrimaryColor),
          ),
          Text(
            "${myCart.getItems().length} items",
            textAlign: TextAlign.start,
            // style: Theme.of(context).textTheme.caption,
            style: TextStyle(fontSize: 12, color: kPrimaryColor),
          ),
        ],
      ),
    );
  }
}
