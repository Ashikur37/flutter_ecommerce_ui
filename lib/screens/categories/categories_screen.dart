import 'package:commerce/helper/http.dart';
import 'package:commerce/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  static String routeName = "/categories";

  @override
  Widget build(BuildContext context) {
    _loadCategories() async {
      var provider = Provider.of<CategoryProvider>(context, listen: false);
      if (!provider.isLoaded) {
        var cats = await getHttp("https://easymert.com/api/categories");
        //
        provider.setCategories(cats["data"]);
        provider.isLoaded = true;
        provider.activeCategory = cats["data"][0]["name"];
        var catId = cats["data"][0]["id"];
        var prods =
            await getHttp("https://easymert.com/api/category/$catId/products");
        print(prods["data"]);
        provider.setProducts(prods["data"]);
        provider.notifyListeners();
      }
    }

    _loadProducts(catId) async {
      var provider = Provider.of<CategoryProvider>(context, listen: false);
      var prods =
          await getHttp("https://easymert.com/api/category/$catId/products");
      print(prods["data"]);
      provider.setProducts(prods["data"]);
      provider.notifyListeners();
    }

    _loadCategories();
    return Consumer<CategoryProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Categories"),
          centerTitle: false,
        ),
        body: Row(
          children: [
            SingleChildScrollView(
                child: Container(
              color: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                  value.getCategories.length,
                  (index) => GestureDetector(
                    onTap: () {
                      var provider =
                          Provider.of<CategoryProvider>(context, listen: false);
                      provider.activeCategory =
                          value.getCategories[index]["name"];
                      var catId = value.getCategories[index]["id"];
                      _loadProducts(catId);
                      provider.notifyListeners();
                    },
                    child: Container(
                      height: 105,
                      width: 100,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                                color: Colors.redAccent,
                                width: value.activeCategory ==
                                        value.getCategories[index]["name"]
                                    ? 2
                                    : 0),
                            bottom: BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Image.network(
                              value.getCategories[index]["image"],
                              width: 50,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              value.getCategories[index]["name"],
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )),
            Expanded(
              child: GridView.builder(
                itemCount: value.getProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 5.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                        value.getProducts[index]['image'],
                        width: 50,
                        height: 70,
                      ),
                      Text(
                        value.getProducts[index]['name'],
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
