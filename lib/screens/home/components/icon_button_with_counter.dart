import 'package:commerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';

class IconButtonWithCounter extends StatelessWidget {
  const IconButtonWithCounter({
    Key key,
    this.svgPicture,
    this.numberCount,
    this.press,
  }) : super(key: key);
  final String svgPicture, numberCount;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(50),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            height: getProportionateScreenWidth(46),
            width: getProportionateScreenWidth(46),
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(svgPicture),
          ),
          if (numberCount != "0")
            Positioned(
              right: 0,
              top: -3,
              child: Container(
                height: getProportionateScreenWidth(16),
                width: getProportionateScreenWidth(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.5,
                    color: Colors.white,
                  ),
                  color: Color(
                    0xFFFF4848,
                  ),
                ),
                child: Center(
                  child: Text(
                    numberCount,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                      color: Colors.white,
                      height: 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
