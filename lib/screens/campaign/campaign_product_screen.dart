import 'package:commerce/components/product_detail.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';

class CampaignProductScreen extends StatefulWidget {
  static String routeName = "/campaign_product";
  @override
  _CampaignProductScreenState createState() => _CampaignProductScreenState();
}

class _CampaignProductScreenState extends State<CampaignProductScreen> {
  bool isLoading = true;
  List products = [];
  void loadProducts(id) async {
    if (isLoading) {
      var prod = await getHttp("$baseUrl/campaign/$id/products");
      setState(() {
        products = prod["data"];
        isLoading = false;
      });
      print(prod);
    }
  }

  @override
  Widget build(BuildContext context) {
    final CampaignProductArguments agrs =
        ModalRoute.of(context).settings.arguments;
    loadProducts(agrs.campaign["id"]);
    return Scaffold(
      appBar: AppBar(
        title: Text(agrs.campaign["title"]),
      ),
      body: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     Row(
          //       children: [
          //         Icon(
          //           Icons.call_outlined,
          //           size: 19,
          //         ),
          //         Text(
          //           agrs.campaign["phone"],
          //           style: TextStyle(
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //       ],
          //     ),
          //     Row(
          //       children: [
          //         Icon(Icons.location_on_outlined, size: 19),
          //         Text(
          //           agrs.campaign["location"],
          //           style: TextStyle(
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
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

class CampaignProductArguments {
  final campaign;
  CampaignProductArguments(this.campaign);
}
