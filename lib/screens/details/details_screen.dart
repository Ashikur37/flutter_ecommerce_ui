import 'package:commerce/components/coustom_bottom_nav_bar.dart';
import 'package:commerce/components/custom_product_nav_bar.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/cart/cart_screen.dart';
import 'package:commerce/utilities/const.dart';
import 'package:commerce/utilities/my_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_response_wrapper.dart';

import '../../enums.dart';
import '../../models/Product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var product;
  var isLoading = true;
  var colorPrice = 0;
  var sizePrice = 0;
  var optionPrices = [];
  var colorIndex = -1;
  var sizeIndex = -1;
  void loadProduct(id) async {
    if (isLoading) {
      var prod = await getHttp("$baseUrl/products/$id");
      setState(() {
        product = prod["data"];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var price = isLoading ? 0 : product["price"] + colorPrice + sizePrice;
    final ProductDetailsArguments agrs =
        ModalRoute.of(context).settings.arguments;
    loadProduct(agrs.productId);
    showMessage(String msg, Color color) {
      final snackBar = SnackBar(
        content: Text(msg),
        backgroundColor: color,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    void addToCart(bool buyNow) {
      if (product["colors"].length > 0 && colorIndex == -1) {
        showMessage("Please select color", Colors.redAccent);
      } else if (product["sizes"].length > 0 && sizeIndex == -1) {
        showMessage("Please select size", Colors.redAccent);
      } else {
        var data = MyCart().addToCart({
          "product": product,
          "colorIndex": colorIndex,
          "sizeIndex": sizeIndex
        }, "$colorIndex$sizeIndex", price);
        showMessage("Product  added to cart", Colors.greenAccent);
        if (buyNow) {
          Navigator.popAndPushNamed(context, CartScreen.routeName);
        }
      }
    }

    return Scaffold(
      // backgroundColor: Color(0XFFf7f8fa),
      // appBar: AppBar(),
      appBar: CustomAppBar(
        rating: 1.0,
      ),
      bottomNavigationBar: CustomProductNavBar(
        stock: isLoading ? true : product['stock'],
        addToCart: addToCart,
        productId: agrs.productId,
      ),
      body: isLoading
          ? SizedBox()
          : Body(
              product: product,
              showMessage: showMessage,
              updateColor: (index, price) {
                setState(() {
                  colorIndex = index;
                  colorPrice = product["colors"][index]["price"];
                });
              },
              updateSize: (index, price) {
                setState(() {
                  sizeIndex = index;
                  sizePrice =
                      int.parse(product["sizes"][index]["price"].toString());
                });
              },
            ),
    );
  }
}

class ProductDetailsArguments {
  final int productId;

  ProductDetailsArguments(this.productId);
}
