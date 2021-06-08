import 'package:commerce/components/rounded_icon_btn.dart';
import 'package:commerce/screens/details/components/color_dots.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductColors extends StatefulWidget {
  final colors;
  const ProductColors({this.colors, this.setColor});
  final Function setColor;
  @override
  _ProductColorsState createState() => _ProductColorsState();
}

class _ProductColorsState extends State<ProductColors> {
  int selectedColor = -1;
  @override
  Widget build(BuildContext context) {
    selectColor(index) {
      setState(() {
        selectedColor = index;
      });
      widget.setColor(index);
    }

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          ...List.generate(
            widget.colors.length,
            (index) => GestureDetector(
              onTap: () => selectColor(index),
              child: ColorDot(
                color: HexColor(widget.colors[index]["color"]["code"]),
                isSelected: index == selectedColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key key,
    @required this.color,
    this.isSelected,
  }) : super(key: key);

  final color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
            Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
