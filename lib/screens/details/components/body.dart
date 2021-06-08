import 'package:commerce/screens/details/components/product_colors.dart';
import 'package:commerce/screens/details/components/product_sizes.dart';
import 'package:commerce/utilities/my_cart.dart';
import 'package:flutter/material.dart';
import 'package:commerce/components/default_button.dart';
import 'package:commerce/models/Product.dart';
import 'package:commerce/size_config.dart';
import 'package:flutter_html/flutter_html.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  final product;
  final Function showMessage;
  final Function updateColor;
  final Function updateSize;

  const Body(
      {Key key,
      @required this.product,
      this.showMessage,
      this.updateColor,
      this.updateSize})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var colorPrice = 0;
  var sizePrice = 0;
  var optionPrices = [];
  var colorIndex = -1;
  var sizeIndex = -1;
  @override
  Widget build(BuildContext context) {
    var price = widget.product["price"] + colorPrice + sizePrice;
    var old_price = widget.product["old_price"];
    if (widget.product["images"].length == 0) {
      widget.product["images"] = [
        {"image": widget.product["image"]}
      ];
    }
    return ListView(
      children: [
        widget.product["images"].length > 0
            ? ProductImages(product: widget.product)
            : SizedBox(),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
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
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough)),
                      ],
                    ),
                  ),
                  widget.product["colors"].length > 0
                      ? ProductColors(
                          colors: widget.product["colors"],
                          setColor: (index) {
                            widget.updateColor(index,
                                widget.product["colors"][index]["price"]);
                            setState(() {
                              colorIndex = index;
                              colorPrice =
                                  widget.product["colors"][index]["price"];
                            });
                          },
                        )
                      : SizedBox(),
                  widget.product["sizes"].length > 0
                      ? ProductSizes(
                          sizes: widget.product["sizes"],
                          setSize: (index) {
                            widget.updateSize(
                                index, widget.product["sizes"][index]["price"]);
                            setState(() {
                              sizeIndex = index;
                              sizePrice =
                                  widget.product["sizes"][index]["price"];
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
              // TopRoundedContainer(
              //   color: Color(0xFFF6F7F9),
              //   child: Column(
              //     children: [
              //       // ColorDots(product: product),
              //       TopRoundedContainer(
              //         color: Colors.white,
              //         child: Padding(
              //           padding: EdgeInsets.only(
              //             left: SizeConfig.screenWidth * 0.15,
              //             right: SizeConfig.screenWidth * 0.15,
              //             bottom: getProportionateScreenWidth(40),
              //             top: getProportionateScreenWidth(15),
              //           ),
              //           child: DefaultButton(
              //             text: "Add To Cart",
              //             press: () {
              //               if (widget.product["colors"].length > 0 &&
              //                   colorIndex == -1) {
              //                 widget.showMessage(
              //                     "Please select color", Colors.redAccent);
              //               } else if (widget.product["sizes"].length > 0 &&
              //                   sizeIndex == -1) {
              //                 widget.showMessage(
              //                     "Please select size", Colors.redAccent);
              //               } else {
              //                 MyCart().addToCart({
              //                   "product": widget.product,
              //                   "colorIndex": colorIndex,
              //                   "sizeIndex": sizeIndex
              //                 }, "$colorIndex$sizeIndex", price);
              //                 widget.showMessage(
              //                     "Product  added to cart", Colors.greenAccent);
              //               }
              //             },
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
  }
}
