import 'dart:convert';

import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/address/address_list.dart';
import 'package:commerce/screens/cart/components/cart_single.dart';
import 'package:commerce/screens/cart/components/order_card.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class OrderScreen extends StatefulWidget {
  static String routeName = "/order_screen";

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isLoading = true;
  bool showCancel = false;
  String reason = "";
  String method = "";
  Color methodColor = Colors.redAccent;
  int isCod = 1;
  var order = null;
  void loadOrder(id) async {
    if (isLoading) {
      var ord = await getAuthHttp("$baseUrl/orders/$id");

      setState(() {
        isCod = int.parse(ord["data"]["order"]["is_cod"].toString());
        order = ord["data"];
        isLoading = false;
      });
      print(order["order"]["paid_amount"]);
      if (order["order"]["payment_method"] == "Cash On Delivery") {
        setState(() {
          method = "COD";
          methodColor = Colors.green;
        });
      } else if (int.parse(order["order"]["payment_status"]) == 1) {
        setState(() {
          method = "Paid";
          methodColor = Colors.green;
        });
      } else if (int.parse(order["order"]["paid_amount"]) == 0) {
        setState(() {
          method = "Unpaid";
          methodColor = Colors.red;
        });
      } else {
        print(2);

        setState(() {
          method = "Partial";
          methodColor = Colors.pink;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final OrderDetailsArguments agrs =
        ModalRoute.of(context).settings.arguments;
    List status = [
      "Pending",
      "Confirmed",
      "Processing",
      "Picked",
      "Shipped",
      "Delivered",
    ];
    loadOrder(agrs.orderId);
    showMessage(String msg, Color color) {
      final snackBar = SnackBar(
        content: Text(msg),
        backgroundColor: color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Enter reason'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    maxLines: 3,
                    onChanged: (val) {
                      reason = val;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(getProportionateScreenWidth(0)),
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
                    'Close',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    showCancel = false;
                  });
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  color: Colors.green,
                  child: const Text(
                    'Cancel order',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () async {
                  var data = await postAuthHttp(
                      '$baseUrl/order/${agrs.orderId}/cancel-order',
                      jsonEncode({"reason": reason}));
                  Navigator.popAndPushNamed(
                    context,
                    OrderScreen.routeName,
                    arguments: OrderDetailsArguments(agrs.orderId),
                  );
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      
      appBar: AppBar(
        title: Text(
          "Order Details",
          style: TextStyle(fontSize: 20.0, color: kPrimaryColor),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                showCancel = !showCancel;
              });
            },
            child: Container(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.more_vert_outlined)),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Text(
                                  "INVOICE",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "#" + order["order"]["order_number"],
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          showCancel && int.parse(order["order"]["status"]) < 3
                              ? GestureDetector(
                                  onTap: () => _showMyDialog(),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)),
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text("Cancel"),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: SingleChildScrollView(
                          // scrollDirection: Axis.horizontal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Row(
                                  children: List.generate(
                                      status.length,
                                      (index) => Row(
                                            children: [
                                              int.parse(order["order"]
                                                          ["status"]) ==
                                                      (index - 1)
                                                  ? Container(
                                                      width: 20,
                                                      height: 20,
                                                      child: Container(
                                                        width: 10,
                                                        height: 10,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                kPrimaryColor,
                                                            shape: BoxShape
                                                                .circle),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[300],
                                                          shape:
                                                              BoxShape.circle),
                                                    )
                                                  : Container(
                                                      width: 20,
                                                      height: 20,
                                                      child: int.parse(order[
                                                                      "order"]
                                                                  ["status"]) >=
                                                              index
                                                          ? (int.parse(order[
                                                                          "order"]
                                                                      [
                                                                      "status"]) ==
                                                                  6
                                                              ? Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 14.0,
                                                                )
                                                              : Icon(
                                                                  Icons.done,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 14.0,
                                                                ))
                                                          : SizedBox(),
                                                      decoration: BoxDecoration(
                                                          color: (int.parse(order["order"]["status"]) >=
                                                                      index &&
                                                                  int.parse(order["order"][
                                                                          "status"]) !=
                                                                      6)
                                                              ? Colors.green
                                                              : (int.parse(order["order"][
                                                                          "status"]) ==
                                                                      6
                                                                  ? kPrimaryColor
                                                                  : Colors.grey[
                                                                      300]),
                                                          shape:
                                                              BoxShape.circle),
                                                    ),
                                              (status.length - 1) == index
                                                  ? SizedBox()
                                                  : Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .117,
                                                      height: 2,
                                                      color: int.parse(order[
                                                                          "order"]
                                                                      [
                                                                      "status"]) >=
                                                                  index &&
                                                              int.parse(order[
                                                                          "order"]
                                                                      [
                                                                      "status"]) !=
                                                                  6
                                                          ? Colors.green
                                                          : Colors.grey,
                                                    )
                                            ],
                                          )),
                                ),
                              ),
                              SizedBox(height: 3),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    status.length,
                                    (index) => Container(
                                      // width: 50,
                                      width: MediaQuery.of(context).size.width *
                                              .12 +
                                          19,
                                      child: Text(
                                        status[index],
                                        style: TextStyle(fontSize: 10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Order track",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            color: Colors.grey[100],
                            height: 2,
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: List.generate(
                            order["tracks"]["data"].length,
                            (index) => Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 75,
                                  // padding: EdgeInsets.symmetric(horizontal: 20),
                                  margin: EdgeInsets.only(
                                      right: 10.0, top: 1.0, left: 12),
                                  child: Text(
                                    order["tracks"]["data"][index]["at"],
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 3,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(7),
                                              decoration: BoxDecoration(
                                                color: kPrimaryColor,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            index !=
                                                    (order["tracks"]["data"]
                                                            .length -
                                                        1)
                                                ? Container(
                                                    height: 100,
                                                    margin: EdgeInsets.only(
                                                        left: 1.0),
                                                    width: 2,
                                                    color: Colors.grey[400],
                                                  )
                                                : SizedBox()
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                order["tracks"]["data"][index]
                                                    ["title"],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    140,
                                                child: Text(
                                                  order["tracks"]["data"][index]
                                                      ["details"],
                                                  textAlign: TextAlign.justify,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.grey[600],
                                                  ),
                                                  maxLines: 3,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   width: double.infinity,
                      //   color: Colors.grey[100],
                      //   height: 6,
                      // ),
                      Container(
                        width: double.infinity,
                        color: Colors.grey[100],
                        height: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Products",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    List.generate(
                      order["items"].length,
                      (index) => Padding(
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
                          child: CartSingle(
                            cart: order["items"][index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Summary",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: double.infinity,
                          color: Colors.grey[100],
                          height: 2,
                        ),
                        SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Grand total "),
                                Text("৳${order["order"]["total"]}"),
                              ],
                            ),
                            SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Amount paid "),
                                Text("৳${order["order"]["paid_amount"]}"),
                              ],
                            ),
                            SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Delivery charge "),
                                Text("৳${order["order"]["shipping_cost"]}"),
                              ],
                            ),
                            SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Due amount "),
                                Text("৳${order["due"]}"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Payment Status",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10.0),
                              decoration: BoxDecoration(
                                  color: methodColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                method,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: double.infinity,
                          color: Colors.grey[100],
                          height: 2,
                        ),
                        SizedBox(height: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  order["order"]["payment_method"],
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Shipping Address",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Container(
                          // margin: EdgeInsets.all(5.0),
                          width: SizeConfig.screenWidth,
                          // padding: EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 20,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 2),
                                    Text(
                                      "Bill From",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(order["shop_name"]),
                                    SizedBox(height: 2),
                                    Text(
                                      order["address"],
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.clip,
                                      maxLines: 3,
                                    ),
                                    SizedBox(height: 2),
                                    Text(order["phone"]),
                                    SizedBox(height: 2),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width - 20,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.grey.shade200)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 2),
                                    Text(
                                      "Bill To",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(order["order"]["customer_first_name"] +
                                        " " +
                                        order["order"]["customer_last_name"]),
                                    SizedBox(height: 2),
                                    Text(order["order"]["customer_email"]),
                                    SizedBox(height: 2),
                                    Text(order["order"]["billing_address_1"]),
                                    SizedBox(height: 2),
                                    Text(order["order"]["customer_phone"]),
                                    SizedBox(height: 2),
                                    Row(
                                      children: [
                                        Text(order["order"]
                                            ["billing_address_1"]),
                                        Text(order["order"]["billing_city"]),
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    int.parse(order["order"]["status"]) < 3
                                        ? GestureDetector(
                                            onTap: () async {
                                              var id =
                                                  await Navigator.pushNamed(
                                                      context,
                                                      AddressList.routeName);

                                              if (id != null) {
                                                var data = await postAuthHttp(
                                                    '$baseUrl/order/${agrs.orderId}/change-address',
                                                    jsonEncode(
                                                        {"address_id": id}));
                                                Navigator.popAndPushNamed(
                                                  context,
                                                  OrderScreen.routeName,
                                                  arguments:
                                                      OrderDetailsArguments(
                                                          agrs.orderId),
                                                );
                                              }
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 7, horizontal: 12),
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                "Change Delivery Address",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                    SizedBox(height: 2),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: OrderCard(
          isCod: isCod,
          showMessage: showMessage,
          paymentMethod: isLoading ? "" : order["order"]["payment_method"],
          total: isLoading ? "0" : order["order"]["total"],
          orderId: isLoading ? "0" : order["order"]["id"],
          due: isLoading ? "0" : order["due"],
          paidAmount: isLoading ? 0 : order["order"]["paid_amount"],
          paymentStatus: isLoading
              ? 0
              : int.parse(order["order"]["payment_status"].toString()),
          status:
              isLoading ? 0 : int.parse(order["order"]["status"].toString()),
          shippingPaid: isLoading
              ? 0
              : int.parse(order["order"]["shipping_paid"].toString()),
          isLoading: isLoading),
    );
  }
}

class OrderDetailsArguments {
  final int orderId;

  OrderDetailsArguments(this.orderId);
}
