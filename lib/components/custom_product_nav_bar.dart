import 'package:commerce/screens/chatscreen/chat_screen.dart';
import 'package:commerce/screens/store/store_screen.dart';
import 'package:flutter/material.dart';

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
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  StoreScreen.routeName,
                  arguments: StoreArguments(productId, false),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: Text(
                    "STORE",
                    textAlign: TextAlign.center,
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
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: Text(
                    "CHAT",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              stock
                  ? GestureDetector(
                      onTap: () => addToCart(false),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                        ),
                        child: Text(
                          "ADD TO CART",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              stock
                  ? GestureDetector(
                      onTap: () => addToCart(true),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
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
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Text(
                        "Out of stock",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ],
          )),
    );
  }
}
