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
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: subCategory['image'],
              width: 140,
              height: 86,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Color(0xFF00AFB4).withOpacity(.9),
                highlightColor: Colors.amber,
                child: Center(
                  child: Text(
                    'Doddlemart',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(height: 10),
            Text(
              subCategory['name'],
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
