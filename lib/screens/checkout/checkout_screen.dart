import 'dart:convert';

import 'package:commerce/components/checkout_navigation.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/address/address_list.dart';
import 'package:commerce/screens/address/create_address.dart';
import 'package:commerce/screens/cart/components/cart_card.dart';
import 'package:commerce/screens/cart/components/cart_item.dart';
import 'package:commerce/screens/order/order_screen.dart';
import 'package:commerce/size_config.dart';
import 'package:commerce/utilities/const.dart';
import 'package:commerce/utilities/my_cart.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class CheckoutScreen extends StatefulWidget {
  static String routeName = "/checkout";
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isLoading = true;
  var addressId = -1;
  var address;
  var myCart = MyCart();
  var amount = 0;
  var region = "inside_charge";
  bool addressLoading = false;
  bool orderLoading = false;
  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Enter the amount'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    onChanged: (val) {
                      amount = int.parse(val);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(getProportionateScreenWidth(1)),
                      borderSide: BorderSide(color: kTextColor),
                    )),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    color: Colors.redAccent,
                    child: const Text(
                      'Pay Now',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    placeOrder() async {
      if (addressLoading || orderLoading) {
        return;
      }
      if (addressId == -1) {
        final snackBar = SnackBar(
          content: Text("Please select an address"),
          backgroundColor: Colors.redAccent,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        setState(() {
          orderLoading = true;
        });
        // await _showMyDialog();
        var item = [];
        for (var i = 0; i < myCart.cart.cartItem.length; i++) {
          item.add({
            "id": myCart.cart.cartItem[i].productDetails["product"]["id"],
            "quantity": myCart.cart.cartItem[i].quantity,
            "size": myCart.cart.cartItem[i].productDetails["sizeIndex"] == -1
                ? 0
                : myCart.cart.cartItem[i].productDetails["product"]["sizes"]
                        [myCart.cart.cartItem[i].productDetails["sizeIndex"]]
                    ["size"]["id"],
            "color": myCart.cart.cartItem[i].productDetails["colorIndex"] == -1
                ? 0
                : myCart.cart.cartItem[i].productDetails["product"]["colors"]
                        [myCart.cart.cartItem[i].productDetails["colorIndex"]]
                    ["color"]["id"],
          });
          //sizeIndex
        }
        var data = await postAuthHttp('$baseUrl$checkout',
            jsonEncode({"products": item, "address_id": addressId}));
        Navigator.pushNamed(
          context,
          OrderScreen.routeName,
          arguments: OrderDetailsArguments(data["id"]),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Order Confirmation"),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              setState(() {
                addressLoading = true;
              });
              var id =
                  await Navigator.pushNamed(context, AddressList.routeName);
              if (id != null) {
                var data = await getAuthHttp("$baseUrl$getAddress/$id");

                setState(() {
                  addressId = id;
                  address = data;
                  region = data["region"] == "Inside Dhaka"
                      ? "inside_charge"
                      : "outside_charge";
                  addressLoading = false;
                });
              }
            },
            child: Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  Text(
                    "Delivery Address",
                  ),
                  Text(
                    "Select address",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                  addressId == -1 ? SizedBox() : AddressCard(address: address),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: myCart.getItems().length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(10),
                child: Dismissible(
                  key: Key(index.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: CartItem(
                    cart: myCart.cart.cartItem[index],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: CheckoutNavigation(
          addressLoading: addressLoading,
          placeOrder: placeOrder,
          region: region),
    );
  }
}

class AddressCard extends StatelessWidget {
  const AddressCard({
    Key key,
    @required this.address,
  }) : super(key: key);

  final address;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.all(5.0),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 1.0)),
      child: Column(
        children: [
          Text(address["first_name"] + " " + address["last_name"]),
          Text(address["email"]),
          Text(address["mobile"]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(address["street_address"] + " "),
              Text(address["city"]),
            ],
          ),
          Text(address["region"]),
        ],
      ),
    );
  }
}
