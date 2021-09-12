import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.text,
    @required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Color(0xFFF5F6F9),
        onPressed: press,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              color: kPrimaryColor,
              width: 24,
            ),
            SizedBox(width: 15),
            Expanded(
                child: Text(
              text,
              style: TextStyle(fontSize: 15),
            )),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
