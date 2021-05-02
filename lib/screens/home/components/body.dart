import 'package:commerce/constants.dart';
import 'package:commerce/screens/home/components/icon_button_with_counter.dart';
import 'package:commerce/screens/home/components/search_field.dart';
import 'package:commerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          HomeHeader(),
          SizedBox(
            height: 30,
          ),
          DiscountBanner(),
          SizedBox(
            height: 30,
          ),
          Categories(),
        ],
      ),
    ));
  }
}
