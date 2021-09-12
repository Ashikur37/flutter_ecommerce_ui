import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce/components/load_more.dart';
import 'package:commerce/components/product_detail.dart';
import 'package:commerce/constants.dart';
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
      backgroundColor: Color(0XFFf7f8fa),
      appBar: AppBar(
        title: Text(
          "Shops",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.builder(
                controller: _scrollController,
                itemCount: shops.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      StoreScreen.routeName,
                      arguments: StoreArguments(shops[index]["id"], true),
                    ),
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              height: 100,
                              imageUrl: shops[index]["image"],
                              placeholder: (context, url) =>
                                  new Icon(Icons.shop),
                              errorWidget: (context, url, error) =>
                                  new Icon(Icons.store_mall_directory),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            shops[index]["name"],
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
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
      ),
    );
  }
}
