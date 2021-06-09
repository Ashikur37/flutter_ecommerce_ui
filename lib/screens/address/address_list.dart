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
        title: Text("Address List"),
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
              : Column(
                  children: List.generate(
                    addresses.length,
                    (index) => Container(
                      margin: EdgeInsets.all(5.0),
                      width: SizeConfig.screenWidth,
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0)),
                      child: Column(
                        children: [
                          Text(addresses[index]["first_name"] +
                              " " +
                              addresses[index]["last_name"]),
                          Text(addresses[index]["email"]),
                          Text(addresses[index]["mobile"]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(addresses[index]["street_address"] + " "),
                              Text(addresses[index]["city"]),
                            ],
                          ),
                          Text(addresses[index]["region"]),
                        ],
                      ),
                    ),
                  ),
                )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
        onPressed: () {
          Navigator.pushNamed(context, CreateAddress.routeName);
        },
      ),
    );
  }
}
