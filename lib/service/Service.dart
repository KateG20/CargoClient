import 'dart:convert';

// import 'package:flutter1/entity/Key.dart';
import 'package:flutter1/LocalUserProvider.dart';
import 'package:http/http.dart' as http;

import '../entity/Key.dart';
import '../entity/Request.dart';

class Service {
  final url = '10.0.2.2:8080';

  Future<List<Request>> getNewRequests() async {
    var response = await http.get(
        Uri.http(url, 'requests/new/${LocalUserProvider.user.id}'),
        headers: <String, String>{'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      var list = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((r) => Request.fromJson(r))
          .toList();
      return list;
    } else {
      throw Exception('Failed to load new requests');
    }
  }

  Future<List<Request>> getCurrentRequests() async {
    // return http.get(Uri.https('http://localhost:5000/api/trainid?id=15', 'requests/new'));
    var response = await http.get(
        Uri.http(url, 'requests/current/${LocalUserProvider.user.id}'),
        headers: <String, String>{'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((r) => Request.fromJson(r))
          .toList();
    } else {
      throw Exception('Failed to load current requests');
    }
  }

  Future<List<Request>> getArchiveRequests() async {
    // return http.get(Uri.https('http://localhost:5000/api/trainid?id=15', 'requests/new'));
    var response = await http.get(
        Uri.http(url, 'requests/archive/${LocalUserProvider.user.id}'),
        headers: <String, String>{'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((r) => Request.fromJson(r))
          .toList();
    } else {
      throw Exception('Failed to load archive requests');
    }
  }

  Future<Request> postRequest(Request request) async {
    final response = await http.post(
      Uri.http(url, 'request/create'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'price': request.price,
        'shipper': request.shipper,
        'receiver': request.receiver,
        'date': request.date!.millisecondsSinceEpoch -
            DateTime(2020).millisecondsSinceEpoch,
        'duration': request.duration?.inMinutes,
        'distance': request.distance,
        'source': request.source,
        'destination': request.destination,
        'weight': request.weight,
        'description': request.description,
        'status': request.status
      }),
    );
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Request.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to post request');
    }
  }

  Future<Key> getKey(String key) async {
    // String res = JsonEncoder().convert(key);
    // print(res);

    var response = await //http.get(Uri.http(url, 'user/check/key'));
        http.post(Uri.http(url, 'user/check/key'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            // body: JsonEncoder().convert(key)
            body: jsonEncode(<String, String>{'value': key}));
    if (response.statusCode == 200) {
      return Key.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to find key');
    }
  }

  Future<Request> updateRequestStatus(int id, int newStatus) async {
    final http.Response response = await http.put(
        Uri.http(url, 'request/status/$id/$newStatus'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 UPDATED response,
      // then parse the JSON.
      return Request.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 UPDATED response,
      // then throw an exception.
      throw Exception('Failed to update status');
    }
  }

  Future<Request> addRequestToUser(int requestId, int userId) async {
    final response = await http.put(
      Uri.http(url, 'request/add/$requestId/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      }
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 UPDATED response,
      // then parse the JSON.
      return Request.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to add request to user');
    }
  }



// 'requests/filter/$status/$from/$to/$dateFrom/'
  // '$dateTo/$minWeight/$maxWeight/$minPrice/$maxPrice/'
  // '$minDist/$maxDist'
  Future<List<Request>> filterRequests(
      int status,
      String from,
      String to,
      int dateFrom,
      int dateTo,
      int minWeight,
      int maxWeight,
      int minPrice,
      int maxPrice,
      int minDist,
      int maxDist) async {
    var queryParameters = {
      'status': status.toString(),
      'from': from,
      'to': to,
      'dateFrom': dateFrom.toString(),
      'dateTo': dateTo.toString(),
      'minWeight': minWeight.toString(),
      'maxWeight': maxWeight.toString(),
      'minPrice': minPrice.toString(),
      'maxPrice': maxPrice.toString(),
      'minDist': minDist.toString(),
      'maxDist': maxDist.toString(),
    };
    var response = await http.get(
        Uri.http(url, 'requests/filter', queryParameters),
        headers: <String, String>{'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      var list = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((r) => Request.fromJson(r))
          .toList();
      return list;
    } else {
      throw Exception('Failed to filter requests');
    }
  }

  // Future<List<Request>> getNewRequests() async {
  List<Request> getNewRequestsHard() {
    // ура хардкодим
    var requests = [
      Request(500, "Shipper", "Receiver", DateTime.utc(2021, 3, 8),
          Duration(hours: 3), 120, "ТЛЦ", "1Владивосток", 680, "comment"),
      Request(
          500,
          "Shipper",
          "Receiver",
          DateTime.utc(2021, 7, 1),
          Duration(hours: 1, minutes: 12),
          60,
          "2Новосибирск",
          "ТЛЦ",
          680,
          "comment"),
      Request(
          500,
          "Shipper",
          "Receiver",
          DateTime.utc(2021, 7, 1),
          Duration(hours: 1, minutes: 12),
          60,
          "3Новосибирск",
          "ТЛЦ",
          200,
          "comment"),
      Request(
          500,
          "Shipper",
          "Receiver",
          DateTime.utc(2021, 7, 1),
          Duration(hours: 1, minutes: 12),
          60,
          "4Новосибирск",
          "ТЛЦ",
          1200,
          "comment"),
      Request(
          500,
          "Shipper",
          "Receiver",
          DateTime.utc(2021, 7, 1),
          Duration(hours: 1, minutes: 12),
          60,
          "5Новосибирск",
          "ТЛЦ",
          680,
          "comment"),
    ];
    return requests;
  }

  List<Request> getCurrentRequestsHard() {
    // ура хардкодим
    var requests = [
      Request(500, "Shipper", "Receiver", DateTime.utc(2021, 4, 20),
          Duration(hours: 5), 120, "ТЛЦ", "Москва", 680, "comment"),
      Request(
          500,
          "Shipper",
          "Receiver",
          DateTime.utc(2021, 5, 3),
          Duration(minutes: 32),
          60,
          "Александровск-Сахалинский",
          "ТЛЦ",
          680,
          "comment")
    ];
    return requests;
  }

  List<Request> getArchiveRequestsHard() {
    // ура хардкодим
    var requests = [
      Request(500, "Shipper", "Receiver", DateTime.utc(2020, 4, 1),
          Duration(hours: 5), 120, "ТЛЦ", "Санкт-Петербург", 680, "comment"),
      Request(500, "Shipper", "Receiver", DateTime.utc(2020, 12, 21),
          Duration(minutes: 32), 60, "Дмитров", "ТЛЦ", 680, "comment")
    ];
    return requests;
  }
}
