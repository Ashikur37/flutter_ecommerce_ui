import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/cart/components/cart_item.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
                          color: Colors.redAccent,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey[100],
                  height: 6,
                ),
                Text(
                  "Delivery Address",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  width: SizeConfig.screenWidth,
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Text(order["order"]["customer_first_name"] +
                          " " +
                          order["order"]["customer_last_name"]),
                      Text(order["order"]["customer_email"]),
                      Text(order["order"]["billing_address_1"]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                Text(
                  "Products",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: order["items"].length,
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
                        child: CartSingle(
                          cart: order["items"][index],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: OrderCard(
        total: isLoading ? "0" : order["order"]["total"],
      ),
    );
  }
}

class OrderDetailsArguments {
  final int orderId;

  OrderDetailsArguments(this.orderId);
}
