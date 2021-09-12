import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/shop/shops_screen.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  var shops;
  var isLoading = true;
  void loadShop() async {
    if (isLoading) {
      var data = await getHttp("$baseUrl$shopURL");
      setState(() {
        shops = data["data"];
        isLoading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    loadShop();
    return Container(
      height: 330,
      // color: Colors.blue,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Doddlemart Shop",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // GestureDetector(
                //   child: Container(
                //     padding:
                //         EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(29),
                //     ),
                //     child: Text(
                //       "See more",
                //       style: TextStyle(fontWeight: FontWeight.w400),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: isLoading
                ? Shimmer.fromColors(
                    baseColor: Color(0xFF00AFB4).withOpacity(.9),
                    highlightColor: Colors.amber,
                    child: Text(
                      'Doddlemart',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: shops.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.85,
                        crossAxisCount: 3,
                        crossAxisSpacing: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          ShopsScreen.routeName,
                          arguments: ShopsArguments(shops[index]),
                        ),
                        child: Container(
                          // height: 330,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),

                          margin: EdgeInsets.only(
                            bottom: 10,
                            left: 5,
                            right: 5,
                          ),
                          // padding: EdgeInsets.only(bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                // color: Colors.red,
                                child: Image.network(
                                  shops[index]['image'],
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                              Container(
                                // height: 50,
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  shops[index]['name'],
                                  textAlign: TextAlign.center,
                                  // overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
