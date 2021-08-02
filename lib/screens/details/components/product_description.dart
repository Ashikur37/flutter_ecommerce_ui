import 'package:commerce/components/default_button.dart';
import 'package:commerce/screens/details/components/product_colors.dart';
import 'package:commerce/screens/details/components/product_sizes.dart';
import 'package:commerce/screens/details/components/top_rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:commerce/utilities/my_cart.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key key,
    @required this.product,
    this.pressOnSeeMore,
    this.showMessage,
  }) : super(key: key);

  final product;
  final GestureTapCallback pressOnSeeMore;
  final Function showMessage;
  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  var colorPrice = 0;
  var sizePrice = 0;
  var optionPrices = [];
  var colorIndex = -1;
  var sizeIndex = -1;
  @override
  Widget build(BuildContext context) {
    var price = widget.product["price"] + colorPrice + sizePrice;
    var old_price = widget.product["old_price"];

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Text(
                widget.product["name"],
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Row(
                children: [
                  Text(
                    "৳$price",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(price == old_price ? "" : "৳$old_price",
                      style: TextStyle(decoration: TextDecoration.lineThrough)),
                ],
              ),
            ),
            widget.product["colors"].length > 0
                ? ProductColors(
                    colors: widget.product["colors"],
                    setColor: (index) {
                      setState(() {
                        colorIndex = index;
                        colorPrice = widget.product["colors"][index]["price"];
                      });
                    },
                  )
                : SizedBox(),
            widget.product["sizes"].length > 0
                ? ProductSizes(
                    sizes: widget.product["sizes"],
                    setSize: (index) {
                      setState(() {
                        sizeIndex = index;
                        sizePrice = widget.product["sizes"][index]["price"];
                      });
                    },
                  )
                : SizedBox(),
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(20),
                right: getProportionateScreenWidth(64),
              ),
              child: Html(
                  data: widget.product["details"].length > 0
                      ? widget.product["details"]
                      : "No details found"),
            )
          ],
        ),
        TopRoundedContainer(
          color: Color(0xFFF6F7F9),
          child: Column(
            children: [
              // ColorDots(product: product),
              TopRoundedContainer(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.screenWidth * 0.15,
                    right: SizeConfig.screenWidth * 0.15,
                    bottom: getProportionateScreenWidth(40),
                    top: getProportionateScreenWidth(15),
                  ),
                  child: DefaultButton(
                    text: "Add To Cart",
                    press: () {
                      if (widget.product["colors"].length > 0 &&
                          colorIndex == -1) {
                        widget.showMessage(
                            "Please select color", Colors.redAccent);
                      } else if (widget.product["sizes"].length > 0 &&
                          sizeIndex == -1) {
                        widget.showMessage(
                            "Please select size", Colors.redAccent);
                      } else {
                        // print(MyCart().getCart().size);
                        MyCart().addToCart({
                          "product": widget.product,
                          "colorIndex": colorIndex,
                          "sizeIndex": sizeIndex
                        }, "$colorIndex$sizeIndex", price);
                        widget.showMessage(
                            "Product  added to cart", Colors.greenAccent);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
