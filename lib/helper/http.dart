import 'dart:convert';

import 'package:http/http.dart';

getHttp(uri) async {
  print(uri);
  try {
    var response = await get(Uri.parse(uri));
    return jsonDecode(response.body);
  } catch (e) {
    print(e);
  }
}

postHttp(uri, body) async {
  print(uri);
  try {
    var response = await post(Uri.parse(uri), body: body);

    return jsonDecode(response.body);
  } catch (e) {
    print(e);
  }
}
