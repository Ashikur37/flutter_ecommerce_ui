import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce/components/load_more.dart';
import 'package:commerce/components/product_detail.dart';
import 'package:commerce/constants.dart';
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
      backgroundColor: Color(0XFFf7f8fa),
      appBar: AppBar(
        title: Text(
          isStoreLoading ? "" : store["name"],
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
        ),
      ),
      body: isStoreLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: new CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                          height: 250,
                          width: double.infinity,
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          child: Image.network(
                            store["image"],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              top: 0, left: 10, right: 10, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.add_call,
                                    size: 18,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    store["phone"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined, size: 18),
                                  SizedBox(width: 3),
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
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                  // SliverAppBar(
                  //   expandedHeight: 220.0,
                  //   flexibleSpace: new FlexibleSpaceBar(
                  //     background: Image.network(store["image"]),
                  //   ),
                  //   leading: SizedBox(),
                  // ),
                  // SliverAppBar(
                  //   expandedHeight: 30.0,
                  //   title: Container(
                  //     color: Colors.red,
                  //     child: Row(
                  //       // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Icon(
                  //               Icons.call_outlined,
                  //               size: 19,
                  //             ),
                  //             Text(
                  //               store["phone"],
                  //               style: TextStyle(
                  //                 fontWeight: FontWeight.w600,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Row(
                  //           children: [
                  //             Icon(Icons.location_on_outlined, size: 19),
                  //             Text(
                  //               store["address"],
                  //               style: TextStyle(
                  //                 fontWeight: FontWeight.w600,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   leading: SizedBox(),
                  // ),
                  // SliverAppBar(),
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.8),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(
                              right: 5, left: 5, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: ProductDetail(product: products[index]),
                        );
                      },
                      childCount: products.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: isLoadingMore ? LoadMore() : SizedBox(),
                  ),
                ],
              ),
            ),
    );
  }
}

class StoreArguments {
  final productId;
  final merchant;
  StoreArguments(this.productId, this.merchant);
}
