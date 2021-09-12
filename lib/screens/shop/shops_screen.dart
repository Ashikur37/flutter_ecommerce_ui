import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce/components/load_more.dart';
import 'package:commerce/components/product_detail.dart';
import 'package:commerce/constants.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/details/details_screen.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';

class ShopsScreen extends StatefulWidget {
  static String routeName = "/shop";
  @override
  _ShopsScreenState createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  bool isLoading = true;
  List products = [];
  bool isLoadingMore = false;
  String nextPageURL;
  void loadProducts(id) async {
    if (isLoading) {
      var prod = await getHttp("$baseUrl/shop/$id/products");
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
    var prods = await getHttp(nextPageURL);
    setState(() {
      products.addAll(prods["data"]);
      nextPageURL = prods["links"]["next"];
      isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    final ShopsArguments agrs = ModalRoute.of(context).settings.arguments;
    loadProducts(agrs.shop["id"]);
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          _loadMoreProducts();
        }
      }
    });
    return Scaffold(
      backgroundColor: Color(0XFFf7f8fa),
      appBar: AppBar(
        title: Text(
          agrs.shop["name"],
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: Column(
        children: [
          Container(
            // width: MediaQuery.of(context).size.width - 30,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            // color: Colors.red,
            decoration: BoxDecoration(color: Colors.white),
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.add_call,
                          size: 18,
                        ),
                        SizedBox(width: 5),
                        Text(
                          agrs.shop["phone"],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 25),
                        Icon(Icons.location_on_outlined, size: 19),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            agrs.shop["location"],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.8),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: ProductDetail(product: products[index]),
                );
              },
            ),
          ),
          isLoadingMore ? LoadMore() : SizedBox()
        ],
      ),
    );
  }
}

class ShopsArguments {
  final shop;
  ShopsArguments(this.shop);
}
