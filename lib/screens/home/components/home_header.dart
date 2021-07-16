import 'package:flutter/material.dart';
import 'package:commerce/screens/cart/cart_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';
import 'package:url_launcher/url_launcher.dart';

const _url = 'https://m.me/easymert.com.bd';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);
  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // IconButton(
          //     icon: Icon(Icons.menu),
          //     onPressed: () {
          //       Scaffold.of(context).openDrawer();
          //     }),
          SizedBox(),
          SearchField(),
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.facebookMessenger,
              color: Colors.blue,
            ),
            onPressed: _launchURL,
          )
        ],
      ),
    );
  }
}
