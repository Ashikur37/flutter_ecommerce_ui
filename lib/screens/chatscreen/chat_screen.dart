import 'package:commerce/helper/http.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static String routeName = "/chat";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isLoading = true;
  List messages = [];
  String message;
  _loadMessages(id) async {
    if (isLoading) {
      var msg = await getHttp("$baseUrl/$sendMesage/$id");
      setState(() {
        isLoading = false;
        messages = msg["data"];
      });
    }
  }

  _sendMessage() async {}
  @override
  Widget build(BuildContext context) {
    final ChatArguments agrs = ModalRoute.of(context).settings.arguments;
    _loadMessages(agrs.productId);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: List.generate(messages.length, (index) => null),
      ),
      bottomNavigationBar: Container(
        child: Form(
          child: Row(
            children: [
              TextFormField(
                onChanged: (val) {},
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: Text("Send"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChatArguments {
  final int productId;

  ChatArguments(this.productId);
}
