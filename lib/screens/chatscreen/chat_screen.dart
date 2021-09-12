import 'dart:convert';

import 'package:commerce/helper/http.dart';
import 'package:commerce/size_config.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ChatScreen extends StatefulWidget {
  static String routeName = "/chat";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final nameHolder = TextEditingController();
  bool isLoading = true;
  List messages = [];
  String message;
  _loadMessages(id) async {
    if (isLoading) {
      var msg = await getAuthHttp("$baseUrl$getMesage/$id");
      setState(() {
        isLoading = false;
        messages = msg["data"];
      });
    }
  }

  _sendMessage(id) async {
    var msg = await postAuthHttp(
        "$baseUrl$sendMesage/$id", jsonEncode({"message": message}));
    nameHolder.clear();
    setState(() {
      isLoading = true;
    });
    _loadMessages(id);
  }

  @override
  Widget build(BuildContext context) {
    final ChatArguments agrs = ModalRoute.of(context).settings.arguments;
    _loadMessages(agrs.productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                    messages.length,
                    (index) => Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          padding: EdgeInsets.all(10),
                          width: SizeConfig.screenWidth,
                          color: messages[index]["sender"]
                              ? Colors.blueAccent
                              : kPrimaryColor,
                          child: Column(
                            crossAxisAlignment: messages[index]["sender"]
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                messages[index]["message"],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                messages[index]["sent"],
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.right,
                              )
                            ],
                          ),
                        )),
              ),
            ),
            flex: 5,
          ),
          Expanded(
            child: Container(
              // color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                child: SafeArea(
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameHolder,
                        onChanged: (val) {
                          message = val;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                            borderSide: BorderSide(color: Color(0XFF808080)),
                            gapPadding: 5,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _sendMessage(agrs.productId);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                    28,
                                  ),
                                  bottomRight: Radius.circular(
                                    28,
                                  ),
                                ),
                                color: kPrimaryColor,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 22.0),
                              margin: EdgeInsets.only(right: 0.0),
                              child: Text(
                                "Send",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChatArguments {
  final int productId;

  ChatArguments(this.productId);
}
