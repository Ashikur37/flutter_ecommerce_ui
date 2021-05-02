import 'search_field.dart';
import 'package:flutter/material.dart';

import 'icon_button_with_counter.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconButtonWithCounter(
            svgPicture: "assets/icons/Cart Icon.svg",
            numberCount: "0",
            press: () {},
          ),
          IconButtonWithCounter(
            svgPicture: "assets/icons/Bell.svg",
            numberCount: "3",
            press: () {},
          )
        ],
      ),
    );
  }
}
