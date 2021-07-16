import 'package:commerce/components/product_detail.dart';
import 'package:commerce/screens/brand/brand_screen.dart';
import 'package:flutter/material.dart';

class OfferBrand extends StatelessWidget {
  final List brands;

  const OfferBrand({Key key, this.brands}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
              BrandScreen.routeName,
              arguments: BrandArguments(brands[index]),
            ),
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        brands[index]["image"],
                      ),
                    )),
                  ),
                  Text(
                    brands[index]["name"],
                  ),
                ],
              ),
            ),
          );
        },
        childCount: brands.length,
      ),
    );
  }
}
