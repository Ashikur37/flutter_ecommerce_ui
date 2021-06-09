import 'package:commerce/components/checkout_navigation.dart';
import 'package:commerce/screens/address/address_list.dart';
import 'package:commerce/screens/address/create_address.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  static String routeName = "/checkout";
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isLoading = true;
  int addressId = -1;
  placeOrder() {
    if (addressId == -1) {
      final snackBar = SnackBar(
        content: Text("Please select an address"),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Confirmation"),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AddressList.routeName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  Text(
                    "Select address",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.redAccent,
      //   onPressed: () {
      //     Navigator.pushNamed(context, CreateAddress.routeName);
      //   },
      // ),
      bottomNavigationBar: CheckoutNavigation(placeOrder: placeOrder),
    );
  }
}
