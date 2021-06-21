import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce/components/load_more.dart';
import 'package:commerce/components/product_detail.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/details/details_screen.dart';
import 'package:commerce/screens/store/store_screen.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';

class MerchantScreen extends StatefulWidget {
  static String routeName = "/merchant";
  @override
  _MerchantScreenState createState() => _MerchantScreenState();
}

class _MerchantScreenState extends State<MerchantScreen> {
  bool isLoading = true;
  List shops = [];
  bool isLoadingMore = false;
  String nextPageURL;
  void loadShops() async {
    if (isLoading) {
      var prod = await getHttp("$baseUrl/vendors");
      setState(() {
        shops = prod["data"];
        isLoading = false;
        nextPageURL = prod["links"]["next"];
      });
    }
  }

  _loadMoreShops() async {
    setState(() {
      isLoadingMore = true;
    });
    var prods = await getHttp(nextPageURL);
    setState(() {
      shops.addAll(prods["data"]);
      nextPageURL = prods["links"]["next"];
      isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    loadShops();
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          _loadMoreShops();
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Shops"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              itemCount: shops.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    StoreScreen.routeName,
                    arguments: StoreArguments(shops[index]["id"], true),
                  ),
                  child: Container(
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          height: 150,
                          imageUrl: shops[index]["image"],
                          placeholder: (context, url) => new Icon(Icons.shop),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.store_mall_directory),
                        ),
                        Text(shops[index]["name"])
                      ],
                    ),
                  ),
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
