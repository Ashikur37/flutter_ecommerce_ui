import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce/screens/sub_category/sub_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SubCategoryDetail extends StatelessWidget {
  const SubCategoryDetail({
    Key key,
    @required this.subCategory,
  }) : super(key: key);

  final subCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          SubCategoryScreen.routeName,
          arguments: SubCategoryArgumentsArguments(this.subCategory),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: subCategory['image'],
            width: 150,
            height: 100,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.red,
              highlightColor: Colors.yellow,
              child: Text(
                'Easymert',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Text(
            subCategory['name'],
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
