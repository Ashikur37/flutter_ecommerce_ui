import 'package:flutter/material.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
            text: "A summer surprise\n",
            style: TextStyle(
              color: Colors.white,
            ),
            children: [
              TextSpan(
                  text: "Cashback 20%",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
            ]),
      ),
    );
  }
}
