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
  final paidAmount;
  final bool isLoading;
  final Function showMessage;
  final int shippingPaid;
  final int paymentStatus;
  final int status;
  final int isCod;
  const OrderCard({
    Key key,
    this.total,
    this.orderId,
    this.due,
    this.showMessage,
    this.paymentMethod,
    this.isLoading,
    this.shippingPaid,
    this.paidAmount,
    this.paymentStatus,
    this.status,
    this.isCod,
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Enter the amount'),
                TextButton(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    color: Colors.red,
                    child: const Text(
                      'X',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
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
                  color: kPrimaryColor,
                  child: const Text(
                    'Pay With Doddle Balance',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () async {
                  // Navigator.of(context).pop();
                  print("here");
                  var data = await getAuthHttp(
                      '$baseUrl/order/${widget.orderId}/pay-with-balance');
                  print(data);
                  if (data["success"]) {
                    Navigator.popAndPushNamed(
                      context,
                      OrderScreen.routeName,
                      arguments: OrderDetailsArguments(widget.orderId),
                    );
                  } else {
                    Navigator.pop(context);
                    widget.showMessage(
                        "Insufficient balance", Colors.redAccent);
                  }

                  // data["data"]["id"]
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
        child: widget.paymentMethod == "Cash On Delivery" && widget.status > 0
            ? SizedBox()
            : Column(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.start,
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
                                    text: "৳" + widget.total.toString(),
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            //Cash On Delivery
                            widget.paymentMethod == "Cash On Delivery"
                                ? CashOnDelivery(
                                    shippingPaid: widget.shippingPaid,
                                    orderId: widget.orderId,
                                    status: widget.status,
                                    paymentStatus: widget.paymentStatus)
                                : (int.parse(widget.paidAmount.toString()) >
                                            0 ||
                                        widget.paymentStatus == 1
                                    ? SizedBox()
                                    : widget.isCod == 1
                                        ? GestureDetector(
                                            onTap: () async {
                                              var data = await postAuthHttp(
                                                  '$baseUrl/order/${widget.orderId}/cash-on-delivery',
                                                  jsonEncode(
                                                      {"amount": amount}));
                                              widget.showMessage(
                                                  "Payment updated to cash on delivery",
                                                  Colors.green);
                                              Navigator.popAndPushNamed(
                                                context,
                                                OrderScreen.routeName,
                                                arguments:
                                                    OrderDetailsArguments(
                                                        widget.orderId),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 5.0),
                                              color: kPrimaryColor,
                                              child: Text(
                                                "Cash On Delivery",
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox()),
                            widget.paymentMethod == "Cash On Delivery"
                                ? SizedBox()
                                : (widget.paymentStatus == 0
                                    ? GestureDetector(
                                        onTap: () {
                                          _showMyDialog();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                          color: kPrimaryColor,
                                          child: Text(
                                            "Pay Now",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Row(
                                        children: [
                                          Text("Payment Successfull",
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.green,
                                              )),
                                        ],
                                      ))
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
  final int paymentStatus;
  final int status;

  const CashOnDelivery({
    Key key,
    this.shippingPaid,
    this.orderId,
    this.paymentStatus,
    this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return paymentStatus > 0 || status > 0
        ? Text(
            "Cash On Delivery",
            style: TextStyle(fontSize: 20.0, color: Colors.green),
          )
        : GestureDetector(
            onTap: () async {
              var data =
                  await getAuthHttp('$baseUrl/order/${orderId}/confirm-order');

              // data["data"]["id"]
              Navigator.pushNamed(
                context,
                OrderScreen.routeName,
                arguments: OrderDetailsArguments(orderId),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10)),
              child: Text(
                "Confirm Orders ",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
  }
}
//easymertlive
//606D47510A77720335
