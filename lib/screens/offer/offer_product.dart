import 'package:commerce/components/product_detail.dart';
import 'package:flutter/material.dart';

class OfferProduct extends StatelessWidget {
  final List products;

  const OfferProduct({Key key, this.products}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.8),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return ProductDetail(product: products[index]);
        },
        childCount: products.length,
      ),
    );
  }
}
