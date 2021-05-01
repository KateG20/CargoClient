import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Request.dart';

class Service {
  static final baseUrl = '10.0.2.2';
  final urlGetNew = "http://" + baseUrl + ":8080/new";

  Future<List<Request>> getNewReqs() async {
    // return http.get(Uri.https('http://localhost:5000/api/trainid?id=15', 'requests/new'));
    var response = await http.get(Uri.https(urlGetNew, 'requests/new'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return (json.decode(response.body) as List)
          .map((i) => Request.fromJson(i))
          .toList();
      // return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load new requests');
    }
  }

  // Future<List<Request>> getNewRequests() async {
  List<Request> getNewRequests() {
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

  List<Request> getCurrentRequests() {
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

  List<Request> getArchiveRequests() {
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
