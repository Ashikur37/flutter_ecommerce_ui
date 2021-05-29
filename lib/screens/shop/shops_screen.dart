import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce/components/product_detail.dart';
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
  void loadProducts(id) async {
    if (isLoading) {
      var prod = await getHttp("$baseUrl/shop/$id/products");
      setState(() {
        products = prod["data"];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ShopsArguments agrs = ModalRoute.of(context).settings.arguments;
    loadProducts(agrs.shop["id"]);
    return Scaffold(
      appBar: AppBar(
        title: Text(agrs.shop["name"]),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.call_outlined,
                    size: 19,
                  ),
                  Text(
                    agrs.shop["phone"],
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
                    agrs.shop["location"],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ProductDetail(product: products[index]);
                ;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ShopsArguments {
  final shop;
  ShopsArguments(this.shop);
}
