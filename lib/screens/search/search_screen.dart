import 'package:commerce/components/product_detail.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';
import '../../size_config.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = "/search";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List products = [];
  bool isLoading = false;
  String key = "";
  void loadProducts(param) async {
    if (param.length > 0) {
      var prod = await getHttp("$baseUrl$productSearchUrl/$param");
      print("$baseUrl/$productSearchUrl/$param");
      setState(() {
        products = prod["data"];
        isLoading = false;
        key = param;
      });
    }
  }

  void loadMoreProducts() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFf7f8fa),
      body: SafeArea(
        child: Column(
          children: [
            // SizedBox(height: getProportionateScreenHeight(18)),

            Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    // child: Text(
                    //   "Cancel",
                    //   style: TextStyle(fontWeight: FontWeight.w600),
                    // ),
                    child: Container(
                      margin: EdgeInsets.only(left: 14, top: 3),
                      // color: Colors.red,
                      child: Icon(
                        Icons.arrow_back,
                        size: 26,
                        color: Color(0XFF505050),
                      ),
                    ),
                  ),
                  Container(
                    height: 46,
                    margin: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.04,
                        right: SizeConfig.screenWidth * 0.048),
                    width: SizeConfig.screenWidth * 0.785,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextField(
                      autofocus: true,
                      onChanged: (value) => loadProducts(value),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 14.5,
                        ),
                        // contentPadding: EdgeInsets.symmetric(
                        //     horizontal: getProportionateScreenWidth(20),
                        //     vertical: getProportionateScreenWidth(9)),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: "Search product",
                        // prefixIcon: SvgPicture.asset(
                        //   "assets/icons/search.svg",
                        //   width: 10,
                        // ),
                        prefixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 3.0),
                              // color: Colors.red,
                              child: SvgPicture.asset(
                                "assets/icons/search.svg",
                                width: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(6)),
            Expanded(
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.8),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin:
                          EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: ProductDetail(product: products[index]));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
