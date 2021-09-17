import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce/components/coustom_bottom_nav_bar.dart';
import 'package:commerce/components/load_more.dart';
import 'package:commerce/components/product_detail.dart';
import 'package:commerce/constants.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/details/details_screen.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';

class WishListsScreen extends StatefulWidget {
  static String routeName = "/wish_list";
  @override
  _WishListsScreenState createState() => _WishListsScreenState();
}

class _WishListsScreenState extends State<WishListsScreen> {
  bool isLoading = true;
  List products = [];
  bool isLoadingMore = false;
  String nextPageURL;
  void loadProducts() async {
    if (isLoading) {
      var prod = await getAuthHttp("$baseUrl/wish-list/products");
      setState(() {
        products = prod["data"];
        isLoading = false;
        nextPageURL = prod["links"]["next"];
      });
    }
  }

  _loadMoreProducts() async {
    setState(() {
      isLoadingMore = true;
    });
    var prods = await getAuthHttp(nextPageURL);
    setState(() {
      products.addAll(prods["data"]);
      nextPageURL = prods["links"]["next"];
      isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    loadProducts();
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          _loadMoreProducts();
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wish List",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: products.length > 0
          ? Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.9),
                    itemBuilder: (BuildContext context, int index) {
                      return ProductDetail(product: products[index]);
                    },
                  ),
                ),
                isLoadingMore ? LoadMore() : SizedBox()
              ],
            )
          : Center(
              child: Text(
                "Empty list",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w500),
              ),
            ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.wishlist),
    );
  }
}
