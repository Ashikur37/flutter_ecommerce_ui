import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce/components/load_more.dart';
import 'package:commerce/components/product_detail.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/details/details_screen.dart';
import 'package:commerce/size_config.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatefulWidget {
  static String routeName = "/store";
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  bool isLoading = true;
  bool isStoreLoading = true;
  List products = [];
  bool isLoadingMore = false;
  var store;
  String nextPageURL;
  void loadProducts(id, isMerchant) async {
    if (isLoading) {
      var prod;
      if (isMerchant) {
        prod = await getHttp("$baseUrl/merchant/$id/products");
      } else {
        print("$baseUrl/store/$id/products");
        prod = await getHttp("$baseUrl/store/$id/products");
      }
      setState(() {
        products = prod["data"];
        isLoading = false;
        nextPageURL = prod["links"]["next"];
      });
    }
  }

  void loadStore(id, isMerchant) async {
    print(id);
    if (isStoreLoading) {
      var st;
      if (isMerchant) {
        st = await getHttp("$baseUrl/merchant/$id");
      } else {
        st = await getHttp("$baseUrl/store/$id");
      }

      setState(() {
        store = st["data"];
        isStoreLoading = false;
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
    final StoreArguments agrs = ModalRoute.of(context).settings.arguments;
    loadStore(agrs.productId, agrs.merchant);
    loadProducts(agrs.productId, agrs.merchant);
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
          isStoreLoading ? "" : store["name"],
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isStoreLoading
          ? CircularProgressIndicator()
          : new CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  expandedHeight: 250.0,
                  flexibleSpace: new FlexibleSpaceBar(
                    background: Image.network(store["image"]),
                  ),
                  leading: SizedBox(),
                ),
                SliverAppBar(
                  expandedHeight: 80.0,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.call_outlined,
                            size: 19,
                          ),
                          Text(
                            store["phone"],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, size: 19),
                          Text(
                            store["address"],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  leading: SizedBox(),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.8),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ProductDetail(product: products[index]);
                    },
                    childCount: products.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: isLoadingMore ? LoadMore() : SizedBox(),
                ),
              ],
            ),
    );
  }
}

class StoreArguments {
  final productId;
  final merchant;
  StoreArguments(this.productId, this.merchant);
}
