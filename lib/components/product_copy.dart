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
                baseColor: Colors.red,
                highlightColor: Colors.yellow,
                child: Text(
                  'Doddle',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Text(
              product['name'],
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontWeight: FontWeight.w600, height: 1.1),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "৳$price",
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                product['discount_percent'] > 0 ? product['old_price'] : "",
                style: TextStyle(decoration: TextDecoration.lineThrough),
              ),
            ],
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
          product['discount_percent'] > 0
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    // color: kPrimaryColor,
                    color: Colors.grey,
                  ),
                  child: Text(
                    "${product['discount_percent']}% OFF",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : SizedBox(),
          product['stock']
              ? Container(
                  child: Text("Stock available"),
                )
              : Container(
                  child: Text("Out of stock"),
                )
        ],
      ),
    );
  }
}
