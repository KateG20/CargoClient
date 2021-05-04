import 'dart:convert';

import 'package:http/http.dart' as http;

import '../entity/Request.dart';

class Service {
  final url = '10.0.2.2:8080';

  Future<List<Request>> getNewRequests() async {
    var response = await http.get(Uri.https(url, 'requests/new'));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((r) => Request.fromJson(r))
          .toList();
    } else {
      throw Exception('Failed to load new requests');
    }
  }

  Future<List<Request>> getCurrentRequests() async {
    // return http.get(Uri.https('http://localhost:5000/api/trainid?id=15', 'requests/new'));
    var response = await http.get(Uri.https(url, 'requests/current'));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((r) => Request.fromJson(r))
          .toList();
    } else {
      throw Exception('Failed to load current requests');
    }
  }

  Future<List<Request>> getArchiveRequests() async {
    // return http.get(Uri.https('http://localhost:5000/api/trainid?id=15', 'requests/new'));
    var response = await http.get(Uri.https(url, 'requests/archive'));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((r) => Request.fromJson(r))
          .toList();
    } else {
      throw Exception('Failed to load archive requests');
    }
  }

  Future<Request> postRequest(Request request) async {
    final response = await http.post(Uri.http(url, 'request'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: //JsonEncoder().convert(request)
      jsonEncode(<String, dynamic>{
      'price': request.price,
      'shipper': request.shipper,
      'receiver': request.receiver,
      'date': request.date?.millisecondsSinceEpoch,
      'duration': request.duration?.inMilliseconds,
      'distance': request.distance,
      'source': request.source,
      'destination': request.destination,
      'weight': request.weight,
      'description': request.description
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

  // Future<List<Request>> getNewRequests() async {
  List<Request> getNewRequestsHard() {
    // var url = Uri.parse('https://example.com/whatsit/create');
    // // var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
    // var response = http.post(url, body: {'name': 'doodle', 'color': 'blue'});
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    // print(await http.read('https://example.com/foobar.txt'));

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
