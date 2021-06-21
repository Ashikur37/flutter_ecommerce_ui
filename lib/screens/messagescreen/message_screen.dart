import 'package:cached_network_image/cached_network_image.dart';
import 'package:commerce/components/load_more.dart';
import 'package:commerce/components/product_detail.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/chatscreen/chat_screen.dart';
import 'package:commerce/screens/details/details_screen.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  static String routeName = "/message";
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  bool isLoading = true;
  List chats = [];
  bool isLoadingMore = false;
  String nextPageURL;
  void loadShops() async {
    if (isLoading) {
      var prod = await getAuthHttp("$baseUrl/get-chat");
      print(prod);
      setState(() {
        chats = prod["data"];
        isLoading = false;
      });
    }
  }

  _loadMoreShops() async {
    setState(() {
      isLoadingMore = true;
    });
    var prods = await getHttp(nextPageURL);
    setState(() {
      chats.addAll(prods["data"]);
      nextPageURL = prods["links"]["next"];
      isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    loadShops();
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent) {
          _loadMoreShops();
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Inbox"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: Column(
            children: List.generate(
              chats.length,
              (index) => GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ChatScreen.routeName,
                    arguments: ChatArguments(chats[index]["id"]),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, left: 5.0),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        height: 50,
                        imageUrl: chats[index]["product_image"],
                        placeholder: (context, url) => new Icon(Icons.shop),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.store_mall_directory),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chats[index]["message"],
                            style: TextStyle(fontSize: 19.0),
                          ),
                          Text(
                            chats[index]["sent"],
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
          isLoadingMore ? LoadMore() : SizedBox()
        ],
      ),
    );
  }
}
