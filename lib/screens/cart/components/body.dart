import 'package:commerce/utilities/my_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:commerce/models/Cart.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  final Function updateCart;

  const Body({Key key, this.updateCart}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var myCart = MyCart();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: myCart.getItems().length == 0
          ? Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.redAccent),
              ),
            )
          : ListView.builder(
              itemCount: myCart.getItems().length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 0),
                child: Dismissible(
                  key: Key(index.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      demoCarts.removeAt(index);
                    });
                  },
                  background: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        SvgPicture.asset("assets/icons/Trash.svg"),
                      ],
                    ),
                  ),
                  child: Container(
                    child: CartCard(
                      cart: myCart.cart.cartItem[index],
                      increment: () {
                        myCart.cart.incrementItemToCart(index);
                        setState(() {
                          myCart = MyCart();
                        });
                        widget.updateCart();
                      },
                      decrement: () {
                        myCart.cart.decrementItemFromCart(index);
                        setState(() {
                          myCart = MyCart();
                        });
                        widget.updateCart();
                      },
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
