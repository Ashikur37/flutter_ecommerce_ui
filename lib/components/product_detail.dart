import 'package:cached_network_image/cached_network_image.dart';
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
          CachedNetworkImage(
            imageUrl: product['image'],
            width: 150,
            height: 100,
            placeholder: (context, url) => Shimmer.fromColors(
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
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Text(
            product['name'],
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(fontWeight: FontWeight.w600),
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
          product['discount_percent'] > 0
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
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
