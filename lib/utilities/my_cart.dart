import 'package:flutter_cart/flutter_cart.dart';

class MyCart {
  var message;

// Creating the instance of flutter cart package.
  var cart = FlutterCart();
  addToCart(dynamic _product, String u, price) => {
        message = cart.addToCart(
            productId: _product["id"],
            unitPrice: price,
            quantity: 1,

            ///[uniqueCheck] is used to differentiate the type between item
            ///[e.g] the shirt sizes in (LARGE, MEDIUM, SMALL) the [Product ID] will remain same
            ///But if UUID is not present so, how we can differentiate between them? So in this case we will
            ///User the uniqueCheck
            uniqueCheck: u,

            ///[productDetailsObject] is used as a dump variable you can dump your object and any kind of data
            ///that you wanted use in future.
            productDetailsObject: _product),
      };
  removeItemFromCart(int index) => {
        cart.decrementItemFromCart(index),
      };

  /// This function is used to increment the item quantity into cart
  addItemToCart(int index) {
    cart.incrementItemToCart(index);
  }

  getItems() => cart.cartItem;
}
