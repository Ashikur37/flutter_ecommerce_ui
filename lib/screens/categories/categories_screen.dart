import 'package:commerce/constants.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/providers/category_provider.dart';
import 'package:commerce/screens/categories/category_list.dart';
import 'package:commerce/screens/categories/category_product.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  static String routeName = "/categories";
  ScrollController _scrollController = ScrollController();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    _loadCategories() async {
      var provider = Provider.of<CategoryProvider>(context, listen: false);
      provider.isLoadingProduct = true;
      if (!provider.isLoaded) {
        var cats = await getHttp("$baseUrl$categoryURL");
        provider.setCategories(cats["data"]);
        provider.isLoaded = true;
        provider.activeCategory = cats["data"][0]["name"];
        var catId = cats["data"][0]["id"];
        var prods = await getHttp("$baseUrl/category/$catId/products");

        provider.setProducts(prods["data"]);
      } else {
        provider.activeCategory = provider.getCategories[0]["name"];
        var catId = provider.getCategories[0]["id"];
        var prods = await getHttp("$baseUrl/category/$catId/products");

        provider.setProducts(prods["data"]);
      }
      provider.isLoadingProduct = false;
      provider.notifyListeners();
    }

    _loadSubCategories(catId) async {
      var provider = Provider.of<CategoryProvider>(context, listen: false);
      provider.isLoadingProduct = true;
      var prods = await getHttp("$baseUrl/category/$catId/sub_categories");
      provider.setSubCategories(prods["data"]);
      provider.isLoadingProduct = false;
      provider.notifyListeners();
    }

    _loadCategories();

    return Consumer<CategoryProvider>(builder: (context, value, child) {
      return Scaffold(
        key: _globalKey,
        appBar: AppBar(
          title: Text(
            "Categories",
            style: TextStyle(color: kPrimaryColor),
          ),
          centerTitle: false,
        ),
        body: Row(
          children: [
            CategoryList(
              categories: value.getCategories,
              activeCategory: value.activeCategory,
              loadSubCategories: _loadSubCategories,
            ),
            value.isLoadingProduct
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : CategoryProduct(
                    subCategories: value.getSubCategories,
                    scrollController: _scrollController,
                  )
          ],
        ),
      );
    });
  }
}
