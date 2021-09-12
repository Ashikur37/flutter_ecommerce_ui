import 'package:commerce/components/coustom_bottom_nav_bar.dart';
import 'package:commerce/components/side_drawer.dart';
import 'package:commerce/enums.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/order/order_screen.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
  List statusColors = [
    Colors.yellow,
    Colors.greenAccent,
    Colors.pinkAccent,
    Colors.yellow,
    Colors.yellow,
    Colors.yellow,
    Colors.redAccent,
  ];
  List paymentStatus = ["Unpaid", "Paid"];
  int activeIndex = 0;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    setState(() {
      isLoading = true;
    });
    await loadOrder();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    setState(() {
      isLoading = true;
    });
    await loadOrder();
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

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
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.abc),
        appBar: AppBar(
          toolbarHeight: 64,
          backgroundColor: Colors.grey.shade100,
          // centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/home_toggler.svg',
                  width: 23,
                  color: Colors.black,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: Text(
            "Order List",
            style: TextStyle(fontSize: 20.0, color: kPrimaryColor),
          ),
        ),
        drawer: SideDrawer(),
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("pull up load");
              } else if (mode == LoadStatus.loading) {
                body = CircularProgressIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("Load Failed!Click retry!");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("release to load more");
              } else {
                body = Text("No more Data");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 7),
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
                                      width: 3.5,
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 12),
                                child: Text(
                                  status[index],
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   color: Colors.grey[100],
                      //   height: 1,
                      // ),
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
                                    margin: EdgeInsets.only(top: 15),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color: Colors.grey[200],
                                        ),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 10.0),
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
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "৳" +
                                                  orders[index]["total"]
                                                      .toString(),
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 6),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        statusColors[int.parse(
                                                      orders[index]["status"],
                                                    )],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Text(
                                                    status[int.parse(
                                                          orders[index]
                                                              ["status"],
                                                        ) +
                                                        1],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 6),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: (int.parse(orders[
                                                                            index]
                                                                        [
                                                                        "payment_status"]
                                                                    .toString()) ==
                                                                0 &&
                                                            int.parse(orders[
                                                                            index]
                                                                        [
                                                                        "paid_amount"]
                                                                    .toString()) >
                                                                0)
                                                        ? Colors.pinkAccent
                                                        : (orders[index][
                                                                    "payment_status"] ==
                                                                0
                                                            ? Colors.red
                                                            : Colors
                                                                .greenAccent),
                                                  ),
                                                  child: (int.parse(orders[
                                                                          index]
                                                                      [
                                                                      "payment_status"]
                                                                  .toString()) ==
                                                              0 &&
                                                          int.parse(orders[
                                                                          index]
                                                                      [
                                                                      "paid_amount"]
                                                                  .toString()) >
                                                              0)
                                                      ? Text(
                                                          "Partial",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      : Text(
                                                          paymentStatus[
                                                              int.parse(orders[
                                                                          index]
                                                                      [
                                                                      "payment_status"]
                                                                  .toString())],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12),
                                                        ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              orders[index]["order_at"],
                                              style: TextStyle(
                                                fontSize: 16.0,
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
        ));
  }
}
