import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  final List<String> imgList = [
    'https://dhamaka-production.s3-ap-southeast-1.amazonaws.com/images/0cef7071d9993f0dbe218e00a950ca83_1620309987100.jpeg',
    'https://dhamaka-production.s3-ap-southeast-1.amazonaws.com/images/fdc9908ba3fdfdb88367fc2f1d827054_1619932090157.jpeg',
    'https://dhamaka-production.s3-ap-southeast-1.amazonaws.com/images/525f950996c7932bfe06982d27a3c658_1620022288413.jpeg',
    'https://dhamaka-production.s3-ap-southeast-1.amazonaws.com/images/fe215b1e0252033ceeaf7464adfd1289_1620022104066.jpeg'
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
      ),
      items: imgList
          .map((item) => GestureDetector(
                onTap: () {
                  print("tapped");
                },
                child: Container(
                  child: Center(
                      child: Image.network(item,
                          fit: BoxFit.cover, width: double.infinity)),
                ),
              ))
          .toList(),
    );
  }
}
