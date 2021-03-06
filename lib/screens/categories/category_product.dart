import 'package:commerce/components/sub_category_detail.dart';
import 'package:flutter/material.dart';

class CategoryProduct extends StatelessWidget {
  final List subCategories;
  final ScrollController scrollController;
  const CategoryProduct({
    this.subCategories,
    this.scrollController,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        controller: scrollController,
        itemCount: subCategories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 5.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return SubCategoryDetail(subCategory: subCategories[index]);
        },
      ),
    );
  }
}
