import 'dart:convert';

import 'package:flutter1/LocalUserProvider.dart';
import 'package:http/http.dart' as http;

import '../entity/User.dart';
import '../entity/Request.dart';

class UserService {
  final url = '10.0.2.2:8080';

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
      }),
    );
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to post request');
    }
  }
}