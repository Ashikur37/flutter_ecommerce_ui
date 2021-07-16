import 'package:commerce/components/product_detail.dart';
import 'package:commerce/screens/shop/shops_screen.dart';
import 'package:commerce/screens/store/store_screen.dart';
import 'package:flutter/material.dart';

class OfferShop extends StatelessWidget {
  final List shops;

  const OfferShop({Key key, this.shops}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => shops[index]["is_merchant"]
                ? Navigator.pushNamed(
                    context,
                    StoreScreen.routeName,
                    arguments: StoreArguments(
                        shops[index]["id"], shops[index]["is_merchant"]),
                  )
                : Navigator.pushNamed(
                    context,
                    ShopsScreen.routeName,
                    arguments: ShopsArguments(shops[index]),
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
                        shops[index]["image"],
                      ),
                    )),
                  ),
                  Text(
                    shops[index]["name"],
                  ),
                ],
              ),
            ),
          );
        },
        childCount: shops.length,
      ),
    );
  }
}
