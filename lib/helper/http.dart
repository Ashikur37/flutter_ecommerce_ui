import 'dart:convert';

import 'package:commerce/helper/auth.dart';
import 'package:http/http.dart';

getHttp(uri) async {
  try {
    var response = await get(Uri.parse(uri));
    return jsonDecode(response.body);
  } catch (e) {
    print(e);
  }
}

getAuthHttp(uri) async {
  String token = await localGetToken();

  try {
    var response = await get(Uri.parse(uri), headers: {
      'Authorization': 'Bearer $token',
    });

    return jsonDecode(response.body);
  } catch (e) {
    print(e);
  }
}

postAuthHttp(uri, body) async {
  String token = await localGetToken();
  try {
    var response = await post(Uri.parse(uri), body: body, headers: {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    });
    print(response.body);
    return jsonDecode(response.body);
  } catch (e) {
    print(e);
  }
}

postHttp(uri, body) async {
  print(body);
  try {
    var response = await post(Uri.parse(uri), body: body);
    print("------");
    print(response);
    print("------");

    return jsonDecode(response.body);
  } catch (e) {
    print("aaaa------");
    print(e);
    return e;
  }
}
