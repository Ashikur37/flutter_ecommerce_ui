import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  List data = [
    {
      "name": "Rose Gold",
      "image":
          "https://dhamakashopping.com/_next/static/images/logoToggle-f152ea78662039c5bea630103f06ebfa.png"
    },
    {
      "name": "Electra BD",
      "image":
          "https://dhamaka-production.s3-ap-southeast-1.amazonaws.com/images/7ae32776e8199c3a2035c552a4538dd8_1602997184070.jpeg"
    },
    {
      "name": "Redience",
      "image":
          "https://dhamaka-production.s3-ap-southeast-1.amazonaws.com/images/f596361f321cb5e2145bc1ebd93e46e4_1603172452612.jpeg"
    },
    {
      "name": "Eshop Plus",
      "image":
          "https://dhamaka-production.s3-ap-southeast-1.amazonaws.com/images/9f96fc6ecc2fa28a7d4d6e3e4d586d34_1603688350255.png"
    },
    {
      "name": "Zara",
      "image":
          "https://dhamaka-production.s3-ap-southeast-1.amazonaws.com/images/0e39fbbac46e5d26dd06cd2a058c7ee5_1602921740310.png"
    },
    {
      "name": "Digitron",
      "image":
          "https://dhamaka-production.s3-ap-southeast-1.amazonaws.com/images/f329cbd9967c9ea1099364e1e7877a31_1610007879663.png"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Easymert Shop",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
                Text("See more"),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: data.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Image.network(
                      data[index]['image'],
                      width: 100,
                    ),
                    Text(data[index]['name']),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
