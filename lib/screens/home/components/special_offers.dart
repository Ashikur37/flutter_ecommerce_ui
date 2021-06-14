import 'package:commerce/components/load_more.dart';
import 'package:commerce/components/product_detail.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatefulWidget {
  const SpecialOffers({
    Key key,
  }) : super(key: key);

  @override
  _SpecialOffersState createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  bool isLoading = true;
  List products = [];
  bool isLoadingMore = false;
  String nextPageURL;
  void loadProducts() async {
    if (isLoading) {
      var prod = await getHttp("$baseUrl$topProducts");
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
    loadProducts();
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          _loadMoreProducts();
          print("load more");
        }
      }
    });
    return Container(
      height: 510,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Products",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: isLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.red,
                    highlightColor: Colors.yellow,
                    child: Text(
                      'Easymert',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : GridView.builder(
                    itemCount: products.length,
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        crossAxisCount: 2,
                        childAspectRatio: 0.8),
                    itemBuilder: (BuildContext context, int index) {
                      return ProductDetail(product: products[index]);
                    },
                  ),
          ),
          isLoadingMore ? LoadMore() : SizedBox()
        ],
      ),
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key key,
    @required this.category,
    @required this.image,
    @required this.numOfBrands,
    @required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(242),
          height: getProportionateScreenWidth(100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "$numOfBrands Brands")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
