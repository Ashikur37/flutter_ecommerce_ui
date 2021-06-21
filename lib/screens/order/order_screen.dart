import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/cart/components/cart_single.dart';
import 'package:commerce/screens/cart/components/order_card.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';

class OrderScreen extends StatefulWidget {
  static String routeName = "/order_screen";

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isLoading = true;
  var order = null;
  void loadOrder(id) async {
    if (isLoading) {
      var ord = await getAuthHttp("$baseUrl/orders/$id");
      print(ord["data"]["tracks"]);
      setState(() {
        order = ord["data"];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final OrderDetailsArguments agrs =
        ModalRoute.of(context).settings.arguments;
    loadOrder(agrs.orderId);
    showMessage(String msg, Color color) {
      final snackBar = SnackBar(
        content: Text(msg),
        backgroundColor: color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
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
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Text(
                              "Order",
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
                                color: Colors.redAccent,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                            height: 6,
                          ),
                        ],
                      ),
                      Column(
                        children: List.generate(
                          order["tracks"]["data"].length,
                          (index) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 80,
                                margin: EdgeInsets.only(right: 10.0, top: 1.0),
                                child: Text(
                                  order["tracks"]["data"][index]["at"],
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 2,
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
                                              color: Colors.redAccent,
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
                                              height: 10.0,
                                            ),
                                            Text(order["tracks"]["data"][index]
                                                ["details"])
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
                      Container(
                        width: double.infinity,
                        color: Colors.grey[100],
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Shipping Address",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        width: SizeConfig.screenWidth,
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(order["order"]["customer_first_name"] +
                                " " +
                                order["order"]["customer_last_name"]),
                            Text(order["order"]["customer_email"]),
                            Text(order["order"]["billing_address_1"]),
                            Row(
                              children: [
                                Text(order["order"]["billing_address_1"]),
                                Text(order["order"]["billing_city"]),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.grey[100],
                        height: 6,
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
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payment",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.grey[100],
                          height: 6,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Grand total ৳${order["order"]["total"]}"),
                            Text(
                                "Amount paid ৳${order["order"]["paid_amount"]}"),
                            Text("Due amount ৳${order["due"]}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: OrderCard(
          showMessage: showMessage,
          paymentMethod: isLoading ? "" : order["order"]["payment_method"],
          total: isLoading ? "0" : order["order"]["total"],
          orderId: isLoading ? "0" : order["order"]["id"],
          due: isLoading ? "0" : order["due"],
          shippingPaid: isLoading ? 0 : order["order"]["shipping_paid"],
          isLoading: isLoading),
    );
  }
}

class OrderDetailsArguments {
  final int orderId;

  OrderDetailsArguments(this.orderId);
}
