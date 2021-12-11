import 'package:flutter/material.dart';

class LoadMore extends StatelessWidget {
  const LoadMore({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Text(
            "easymartshopping",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
