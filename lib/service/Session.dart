import 'dart:convert';

import 'package:http/http.dart' as http;

class Session {
  Map<String, String> headers = {};

  Future<Map> get(Uri uri) async {
    http.Response response = await http.get(uri, headers: headers);
    updateCookie(response);
    return json.decode(response.body);
  }

  Future<Map> post(Uri uri, dynamic data) async {
    http.Response response = await http.post(uri, body: data, headers: headers);
    updateCookie(response);
    return json.decode(response.body);
  }

  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
      (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}