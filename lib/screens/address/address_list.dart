import 'package:commerce/constants.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/address/create_address.dart';
import 'package:commerce/size_config.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';

class AddressList extends StatefulWidget {
  static String routeName = "/address_list";
  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  bool isLoading = true;
  List addresses = [];
  _loadAddress() async {
    var data = await getAuthHttp("$baseUrl$getAddress");
    // print(data);
    if (isLoading) {
      setState(() {
        addresses = data["data"];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadAddress();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Address List",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : (addresses.length == 0
              ? Center(
                  child: Text(
                    "No address found",
                    style: TextStyle(fontSize: 18.0),
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: List.generate(
                      addresses.length,
                      (index) => GestureDetector(
                        onTap: () {
                          Navigator.pop(context, addresses[index]["id"]);
                        },
                        child: AddressCard(address: addresses[index]),
                      ),
                    ),
                  ),
                )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.pushNamed(context, CreateAddress.routeName);
        },
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  const AddressCard({
    Key key,
    @required this.address,
  }) : super(key: key);

  final address;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(address["first_name"] + " " + address["last_name"]),
          Text(address["email"]),
          Text(address["mobile"]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(address["street_address"] + " "),
              Text(address["city"]),
            ],
          ),
          Text(address["region"]),
        ],
      ),
    );
  }
}
