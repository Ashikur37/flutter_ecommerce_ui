import 'package:commerce/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12, left: SizeConfig.screenWidth * 0.13),
      width: SizeConfig.screenWidth * 0.69,
      height: 44,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(29.0),
      ),
      child: TextField(
        autofocus: false,
        readOnly: true,
        onTap: () => Navigator.pushNamed(context, SearchScreen.routeName),
        onChanged: (value) =>
            Navigator.pushNamed(context, SearchScreen.routeName),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.5,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: "Search Product",
          prefixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 3.0),
                // color: Colors.red,
                child: SvgPicture.asset(
                  "assets/icons/search.svg",
                  width: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
