import 'dart:convert';

import 'file:///C:/Users/Lenovo%20X1/IdeaProjects/flutter1/lib/provider/LocalUserProvider.dart';
import 'package:http/http.dart' as http;

import '../entity/Key.dart';
import '../entity/User.dart';

class UserService {
  final url = '10.0.2.2:8080';

  Future<void> logout() async {
    var response = await http.get(Uri.http(url, 'logout'));
    if (response.statusCode < 200 && response.statusCode >= 400) {
      throw Exception('Failed to logout');
    }
    else print('logged out'); // todo убрать
  }

  Future<User> loginUser(String login, String password) async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$login:$password'));

    var queryParameters = {'login': login};

    var response = await http.get(Uri.http(url, 'login', queryParameters),
        headers: <String, String>{'authorization': basicAuth});

    if (response.statusCode == 200) {
      String? rawCookie = response.headers['set-cookie'];
      if (rawCookie != null) {
        print(rawCookie);
        int index = rawCookie.indexOf(';');
        LocalUserProvider.jSessionId =
            (index == -1) ? rawCookie : rawCookie.substring(0, index);
        return User.fromJson(jsonDecode(response.body));
      } else
        throw Exception('Failed to receive cookie');
    } else {
      throw Exception('Failed to login user');
    }
  }

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

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user');
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
