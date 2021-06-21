import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/order/order_screen.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class OrderList extends StatefulWidget {
  static String routeName = "/order_list";
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List orders = [];
  bool isLoading = true;
  List status = [
    "ALL",
    "PENDING",
    "CONFIRMED",
    "PROCESSING",
    "PICKED",
    "SHIPPED",
    "DELIVERED",
    "CANCELLED",
  ];
  int activeIndex = 0;
  void loadOrder() async {
    if (isLoading) {
      var ord = await getAuthHttp("$baseUrl/orders");
      setState(() {
        orders = ord["data"];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    loadOrder();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order List",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        status.length,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              activeIndex = index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: index == activeIndex
                                      ? kPrimaryColor
                                      : Colors.transparent,
                                  width: 4,
                                ),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              status[index],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey[100],
                    height: 10,
                  ),
                  Column(
                    children: List.generate(
                      orders.length,
                      (index) => (int.parse(
                                        orders[index]["status"],
                                      ) +
                                      1 ==
                                  activeIndex ||
                              activeIndex == 0)
                          ? GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  OrderScreen.routeName,
                                  arguments: OrderDetailsArguments(
                                      orders[index]["id"]),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 3.0,
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          orders[index]["number"],
                                          style: TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        Text(
                                          "৳" + orders[index]["total"],
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          status[int.parse(
                                                orders[index]["status"],
                                              ) +
                                              1],
                                        ),
                                        Text(
                                          orders[index]["order_at"],
                                          style: TextStyle(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
