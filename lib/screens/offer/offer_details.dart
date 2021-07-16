import 'package:commerce/components/product_detail.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/offer/offer_brand.dart';
import 'package:commerce/screens/offer/offer_product.dart';
import 'package:commerce/screens/offer/offer_shop.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';

class OfferDetails extends StatefulWidget {
  static String routeName = "/order_details";
  @override
  _OfferDetailsState createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  List menus = ["Product", "Shop", "Brands"];
  int activeIndex = 0;
  List products = [];
  List shops = [];
  List brands = [];

  bool isLoading = true;
  void loadProducts(id) async {
    if (isLoading) {
      var prod;
      var shop;
      var brand;
      prod = await getHttp("$baseUrl/offer/$id/products");
      shop = await getHttp("$baseUrl/offer/$id/shops");
      brand = await getHttp("$baseUrl/offer/$id/brands");
      List shopList = shops = shop["shops"]["data"];
      shopList.addAll(shop["vendors"]["data"]);
      setState(() {
        products = prod["data"];
        brands = brand["data"];
        shops = shopList;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final OfferArguments agrs = ModalRoute.of(context).settings.arguments;
    loadProducts(agrs.offer["id"]);
    return Scaffold(
      appBar: AppBar(
        title: Text(agrs.offer["name"]),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              child: Row(
                children: List.generate(
                    menus.length,
                    (index) => MenuBox(
                        title: menus[index],
                        isActive: activeIndex == index,
                        updateIndex: () {
                          setState(() {
                            activeIndex = index;
                          });
                        })),
              ),
            ),
          ),
          [
            OfferProduct(
              products: products,
            ),
            OfferShop(
              shops: shops,
            ),
            OfferBrand(
              brands: brands,
            )
          ][activeIndex]
        ],
      ),
    );
  }
}

class MenuBox extends StatelessWidget {
  final String title;
  final bool isActive;
  final Function updateIndex;
  const MenuBox({
    Key key,
    this.title,
    this.isActive,
    this.updateIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: updateIndex,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: isActive
                ? BorderSide(color: Colors.redAccent, width: 2.0)
                : BorderSide.none,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.redAccent : Colors.black),
        ),
      ),
    );
  }
}

class OfferArguments {
  final offer;
  OfferArguments(this.offer);
}
