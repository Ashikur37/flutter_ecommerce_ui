import 'package:commerce/components/rounded_icon_btn.dart';
import 'package:commerce/screens/details/components/color_dots.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductSizes extends StatefulWidget {
  final sizes;
  final Function setSize;
  const ProductSizes({this.sizes, this.setSize});

  @override
  _ProductSizesState createState() => _ProductSizesState();
}

class _ProductSizesState extends State<ProductSizes> {
  int selectedColor = -1;
  @override
  Widget build(BuildContext context) {
    selectColor(index) {
      setState(() {
        selectedColor = index;
      });
      widget.setSize(index);
    }

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          ...List.generate(
            widget.sizes.length,
            (index) => GestureDetector(
              onTap: () => selectColor(index),
              child: SizeDot(
                name: widget.sizes[index]["size"]["name"],
                isSelected: index == selectedColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SizeDot extends StatelessWidget {
  const SizeDot({
    Key key,
    @required this.name,
    this.isSelected,
  }) : super(key: key);

  final name;
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
          border: Border(
            bottom: BorderSide(
              color: isSelected ? kPrimaryColor : Colors.transparent,
              width: 2,
            ),
          )
          // Border. (color: isSelected ? kPrimaryColor : Colors.transparent),
          ),
      child: DecoratedBox(
        child: Text(name),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
