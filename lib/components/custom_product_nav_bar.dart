import 'package:commerce/constants.dart';
import 'package:commerce/screens/chatscreen/chat_screen.dart';
import 'package:commerce/screens/store/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomProductNavBar extends StatelessWidget {
  final Function addToCart;
  final productId;
  final bool stock;
  const CustomProductNavBar(
      {Key key, this.addToCart, this.productId, this.stock})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.25),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  StoreScreen.routeName,
                  arguments: StoreArguments(productId, false),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.10,
                  // child: Text(
                  //   "STORE",
                  //   textAlign: TextAlign.center,
                  // ),
                  // child: Icon(
                  //   Icons.store_outlined,
                  // ),

                  child: SvgPicture.asset(
                    'assets/icons/store-alt-solid.svg',
                    width: 24,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  ChatScreen.routeName,
                  arguments: ChatArguments(productId),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.10,
                  margin: EdgeInsets.only(right: 10, left: 1),
                  // child: Icon(Icons.chat_rounded),
                  child: SvgPicture.asset(
                    'assets/icons/rocketchat.svg',
                    width: 28,
                  ),
                  //  Text(
                  //   "CHAT",
                  //   textAlign: TextAlign.center,
                  // ),
                ),
              ),
              stock
                  ? GestureDetector(
                      onTap: () => addToCart(false),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        padding: EdgeInsets.symmetric(vertical: 7),
                        decoration: BoxDecoration(
                            // color: Colors.amber.shade100,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: kPrimaryColor,
                            )),
                        child: Text(
                          "ADD TO CART",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              stock
                  ? GestureDetector(
                      onTap: () => addToCart(true),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.28,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: Text(
                          "BUY NOW",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Out of stock",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
