import 'dart:convert';

import 'package:commerce/constants.dart';
import 'package:commerce/helper/auth.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatefulWidget {
  final Function showMessage;
  const ProfilePic({
    Key key,
    this.showMessage,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  String username = "";
  String phone = "";
  bool isLoad = true;
  String balance = "0.0";
  File file;
  String status = '';
  String base64Image;
  String avatar = null;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  getUser() async {
    var us = await localGetUser();
    var data = await postAuthHttp(
        "$baseUrl$updateBasic",
        jsonEncode({
          "first_name": us["name"],
          "last_name": us["lastname"],
        }));
    var user = data["user"];
    await updateAvatar(user["avatar"]);
    setState(() {
      username = '${user["name"]}  ${user["lastname"]}';
      phone = user["email"];
      balance = user["easy_balance"].toString();
      avatar = user["avatar"];
      isLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoad) {
      getUser();
    }
    return Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              file != null
                  ? Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
                          border: Border.all(
                            width: 1,
                            color: Colors.grey[100],
                          ),
                          image: DecorationImage(
                            image: FileImage(file),
                          )),
                    )
                  : CircleAvatar(
                      backgroundImage: avatar == null
                          ? AssetImage("assets/images/user.png")
                          : NetworkImage("$rootUrl/images/user/$avatar"),
                    ),
              Positioned(
                right: -1,
                bottom: 5,
                child: GestureDetector(
                  onTap: () async {
                    var pickedFile = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    setState(() {
                      file = File(pickedFile.path);
                      final bytes = File(pickedFile.path).readAsBytesSync();
                      base64Image = base64Encode(bytes);
                    });
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade700.withOpacity(0.25),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.photo_camera,
                      size: 22,
                      // color: Colors.redAccent,
                    ),
                  ),
                ),
              )
              // Positioned(
              //   right: -16,
              //   bottom: 0,
              //   child: SizedBox(
              //     height: 46,
              //     width: 46,
              //     child: FlatButton(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(50),
              //         side: BorderSide(color: Colors.white),
              //       ),
              //       color: Color(0xFFF5F6F9),
              //       onPressed: () {},
              //       child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
        file != null
            ? GestureDetector(
                onTap: () async {
                  var data = await postAuthHttp(
                      '$baseUrl$uploadImage',
                      jsonEncode({
                        "image": base64Image,
                      }));
                  if (data["success"]) {
                    widget.showMessage(data["msg"], Colors.green);
                  }
                  var us = await localGetUser();
                  data = await postAuthHttp(
                      "$baseUrl$updateBasic",
                      jsonEncode({
                        "first_name": us["name"],
                        "last_name": us["lastname"],
                      }));
                  var user = data["user"];
                  await updateAvatar(user["avatar"]);
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kPrimaryColor,
                  ),
                  child: Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : SizedBox(),
        Text(
          username,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        Text(phone),
        GestureDetector(
          onTap: () {
            showBottomSheet(
                context: context,
                builder: (cotx) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.grey.shade200, width: 2.0)),
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    height: 300,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'easymartshopping Account',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(cotx);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              // width: 165,
                              width:
                                  MediaQuery.of(context).size.width * .5 - 30,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 25),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade100, width: 2),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Account"),
                                  Text(
                                    "৳$balance",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * .5 - 30,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 25),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade100, width: 2)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Holding"),
                                  Text(
                                    "৳0",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * .5 - 30,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 25),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade100, width: 2)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Boucher Card"),
                                  Text(
                                    "৳0",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * .5 - 30,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 25),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade100, width: 2)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Cashback"),
                                  Text(
                                    "৳0",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5.0),
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: kPrimaryColor,
            ),
            child: Text(
              "Check Balance",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
