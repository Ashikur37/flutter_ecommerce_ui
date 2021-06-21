import 'dart:convert';
import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/order/order_screen.dart';
import 'package:commerce/screens/payment/delivery_charge_screen.dart';
import 'package:commerce/screens/payment/payment_screen.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class OrderCard extends StatefulWidget {
  final total;
  final orderId;
  final due;
  final paymentMethod;
  final bool isLoading;
  final Function showMessage;
  final int shippingPaid;
  const OrderCard({
    Key key,
    this.total,
    this.orderId,
    this.due,
    this.showMessage,
    this.paymentMethod,
    this.isLoading,
    this.shippingPaid,
  }) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  var amount;
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
                    initialValue: widget.due.toString(),
                    onChanged: (val) {
                      setState(() {
                        amount = val;
                      });
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
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  color: Colors.green,
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () async {
                  if (amount == null) {
                    setState(() {
                      amount = widget.due;
                    });
                  }

                  // Navigator.of(context).pop();
                  var data = await postAuthHttp(
                      '$baseUrl/order/${widget.orderId}/partial-payment',
                      jsonEncode({"amount": amount}));

                  // data["data"]["id"]
                  Navigator.pushNamed(
                    context,
                    PaymentScreen.routeName,
                    arguments:
                        PaymentArguments(data["data"]["id"], widget.orderId),
                  );
                },
              ),
            ],
          );
        },
      );
    }

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
            widget.isLoading
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Total:\n",
                          children: [
                            TextSpan(
                              text: "৳" + widget.total,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      //Cash On Delivery
                      widget.paymentMethod == "Cash On Delivery"
                          ? CashOnDelivery(
                              shippingPaid: widget.shippingPaid,
                              orderId: widget.orderId,
                            )
                          : GestureDetector(
                              onTap: () async {
                                var data = await postAuthHttp(
                                    '$baseUrl/order/${widget.orderId}/cash-on-delivery',
                                    jsonEncode({"amount": amount}));
                                widget.showMessage(
                                    "Payment updated to cash on delivery",
                                    Colors.green);
                                Navigator.popAndPushNamed(
                                  context,
                                  OrderScreen.routeName,
                                  arguments:
                                      OrderDetailsArguments(widget.orderId),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
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
                      widget.paymentMethod == "Cash On Delivery"
                          ? SizedBox()
                          : GestureDetector(
                              onTap: () {
                                _showMyDialog();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
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

class CashOnDelivery extends StatelessWidget {
  final int shippingPaid;
  final int orderId;

  const CashOnDelivery({
    Key key,
    this.shippingPaid,
    this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return shippingPaid == 0
        ? Container(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DeliveryChargeScreen.routeName,
                      arguments: DeliveryArguments(orderId),
                    );
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    color: Colors.redAccent,
                    child: Text(
                      "Pay Delivery Charge",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : Text(
            "Cash on delivery",
            style: TextStyle(fontSize: 20.0, color: Colors.green),
          );
  }
}
//easymertlive
//606D47510A77720335
