import 'package:commerce/screens/search/search_screen.dart';
import 'package:flutter/material.dart';

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
      width: SizeConfig.screenWidth * 0.70,
      height: 45,
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
            // horizontal: getProportionateScreenWidth(0),
            vertical: getProportionateScreenWidth(8),
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
                child: FaIcon(
                  FontAwesomeIcons.search,
                  size: 17,
                  // color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
