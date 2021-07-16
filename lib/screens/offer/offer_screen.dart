import 'package:commerce/components/coustom_bottom_nav_bar.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/offer/offer_details.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';

class OfferScreen extends StatefulWidget {
  static String routeName = "/offer";
  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  bool isLoading = true;
  List offers = [];
  void loadProducts() async {
    if (isLoading) {
      var prod = await getHttp("$baseUrl$offerUrl");
      setState(() {
        offers = prod["data"];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    loadProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text("Offer"),
      ),
      body: GridView.builder(
        itemCount: offers.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, childAspectRatio: 1.5),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              OfferDetails.routeName,
              arguments: OfferArguments(offers[index]),
            ),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              child: Column(
                children: [
                  Image.network(
                    offers[index]["image"],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    offers[index]["name"],
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
