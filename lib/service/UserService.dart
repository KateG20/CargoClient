import 'dart:convert';

import 'package:http/http.dart' as http;

import '../entity/Key.dart';
import '../entity/User.dart';

class UserService {
  final url = '10.0.2.2:8080';
  String? cookie; // тут по идее должен быть куки

  Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.http(url, 'user/create'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'login': user.login,
        'password': user.password,
        'name': user.name,
        'licensePlate': user.licensePlate,
        'company': user.company,
        'keyValue': user.key
      }),
    );
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      cookie = (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to post request');
    }
  }

  Future<Key> checkKey(String keyValue) async {
    var response = await http.post(Uri.http(url, 'user/check/key'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(<String, String>{'value': keyValue}));
    if (response.statusCode == 200) {
      return Key.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to find key');
    }
  }
}
