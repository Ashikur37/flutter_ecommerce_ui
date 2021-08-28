import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce/constants.dart';
import 'package:commerce/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    Key key,
    @required this.product,
  }) : super(key: key);

  final product;

  @override
  Widget build(BuildContext context) {
    var price = product['price'];
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: ProductDetailsArguments(product["id"]),
        );
      },
      child: Stack(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13.0),
                  child: CachedNetworkImage(
                    imageUrl: product['image'],
                    width: 150,
                    height: 100,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Color(0xFF00AFB4).withOpacity(.9),
                      highlightColor: Colors.amber,
                      child: Center(
                        child: Text(
                          'DoddleMart',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.0,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Text(
                    product['name'],
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.w600, height: 1.1),
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  // color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "৳$price",
                        style: TextStyle(
                          color: Colors.red.shade600,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        product['discount_percent'] > 0
                            ? product['old_price']
                            : "",
                        style:
                            TextStyle(decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                ),
                int.parse(product['cashback'].toString()) > 0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Cashback",
                              style: TextStyle(
                                color: kPrimaryColor,
                              ),
                            ),
                            Text("৳${product['cashback']}"),
                          ],
                        ),
                      )
                    : SizedBox(),
                // Container(
                //   child: product['discount_percent'] > 0
                //       ? Container(
                //           padding: EdgeInsets.symmetric(horizontal: 5),
                //           decoration: BoxDecoration(
                //             // color: kPrimaryColor,
                //             color: Colors.grey,
                //           ),
                //           child: Text(
                //             "${product['discount_percent']}% OFF",
                //             style: TextStyle(color: Colors.white),
                //           ),
                //         )
                //       : SizedBox(),
                // ),
                Container(
                  child: product['stock']
                      ? Container(
                          child: Text("Stock available"),
                        )
                      : Container(
                          child: Text("Out of stock"),
                        ),
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              child: product['discount_percent'] > 0
                  ? Container(
                      // padding: EdgeInsets.symmetric(horizontal: 5),
                      // decoration: BoxDecoration(
                      //   // color: kPrimaryColor,
                      //   // color: Colors.grey,

                      // ),
                      padding: EdgeInsets.only(
                          left: 10.0, right: 4, top: 1.5, bottom: 2),
                      decoration: BoxDecoration(
                        color: Color(0xFF00AFB4).withOpacity(.9),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(6),
                        ),
                      ),
                      child: Text(
                        "${product['discount_percent']}% OFF",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.5,
                        ),
                      ),
                    )
                  : SizedBox(),
            ),
          )
        ],
      ),
    );
  }
}
