import 'dart:convert';

import 'package:http/http.dart' as http;

import '../entity/Request.dart';
import '../exception/RequestAcceptConflictException.dart';
import '../provider/LocalUserProvider.dart';

class RequestService {
  final url = '10.0.2.2:8080';

  Future<List<Request>> getNewRequests() async {
    print("JSESSIONID is ${LocalUserProvider.jSessionId}");
    var response = await http.get(
        Uri.http(url, 'requests/new/${LocalUserProvider.user.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Cookie': LocalUserProvider.jSessionId
        });

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
    var response = await http.get(
        Uri.http(url, 'requests/current/${LocalUserProvider.user.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Cookie': LocalUserProvider.jSessionId
        });

    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((r) => Request.fromJson(r))
          .toList();
    } else {
      throw Exception('Failed to load current requests');
    }
  }

  Future<List<Request>> getArchiveRequests() async {
    var response = await http.get(
        Uri.http(url, 'requests/archive/${LocalUserProvider.user.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Cookie': LocalUserProvider.jSessionId
        });

    if (response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((r) => Request.fromJson(r))
          .toList();
    } else {
      throw Exception('Failed to load archive requests');
    }
  }

  Future<void> updateRequestStatus(int id, int newStatus, int userId) async {
    final http.Response response = await http.put(
        Uri.http(url, 'request/status/$id/$newStatus/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Cookie': LocalUserProvider.jSessionId
        });
    if (newStatus == 1) {
      if (response.statusCode == 304) {
        throw RequestAcceptConflictException();
      }
    }
    if (response.statusCode != 200) {
      throw Exception('Failed to update status');
    }
  }

  Future<void> rejectRequest(int requestId, int userId) async {
    final response = await http.put(
        Uri.http(url, 'request/reject/$requestId/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Cookie': LocalUserProvider.jSessionId
        });
    if (response.statusCode != 200) {
      throw Exception('Failed to reject request');
    }
  }

  Future<List<Request>> filterRequests(
      int status,
      int userId,
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
      'userId': userId.toString(),
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
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Cookie': LocalUserProvider.jSessionId
        });

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
// List<Request> getNewRequestsHard() {
//   // ура хардкодим
//   var requests = [
//     Request(500, "Shipper", "Receiver", DateTime.utc(2021, 3, 8),
//         Duration(hours: 3), 120, "ТЛЦ", "1Владивосток", 680, "comment"),
//     Request(
//         500,
//         "Shipper",
//         "Receiver",
//         DateTime.utc(2021, 7, 1),
//         Duration(hours: 1, minutes: 12),
//         60,
//         "2Новосибирск",
//         "ТЛЦ",
//         680,
//         "comment"),
//     Request(
//         500,
//         "Shipper",
//         "Receiver",
//         DateTime.utc(2021, 7, 1),
//         Duration(hours: 1, minutes: 12),
//         60,
//         "3Новосибирск",
//         "ТЛЦ",
//         200,
//         "comment"),
//     Request(
//         500,
//         "Shipper",
//         "Receiver",
//         DateTime.utc(2021, 7, 1),
//         Duration(hours: 1, minutes: 12),
//         60,
//         "4Новосибирск",
//         "ТЛЦ",
//         1200,
//         "comment"),
//     Request(
//         500,
//         "Shipper",
//         "Receiver",
//         DateTime.utc(2021, 7, 1),
//         Duration(hours: 1, minutes: 12),
//         60,
//         "5Новосибирск",
//         "ТЛЦ",
//         680,
//         "comment"),
//   ];
//   return requests;
// }
//
// List<Request> getCurrentRequestsHard() {
//   // ура хардкодим
//   var requests = [
//     Request(500, "Shipper", "Receiver", DateTime.utc(2021, 4, 20),
//         Duration(hours: 5), 120, "ТЛЦ", "Москва", 680, "comment"),
//     Request(
//         500,
//         "Shipper",
//         "Receiver",
//         DateTime.utc(2021, 5, 3),
//         Duration(minutes: 32),
//         60,
//         "Александровск-Сахалинский",
//         "ТЛЦ",
//         680,
//         "comment")
//   ];
//   return requests;
// }
//
// List<Request> getArchiveRequestsHard() {
//   // ура хардкодим
//   var requests = [
//     Request(500, "Shipper", "Receiver", DateTime.utc(2020, 4, 1),
//         Duration(hours: 5), 120, "ТЛЦ", "Санкт-Петербург", 680, "comment"),
//     Request(500, "Shipper", "Receiver", DateTime.utc(2020, 12, 21),
//         Duration(minutes: 32), 60, "Дмитров", "ТЛЦ", 680, "comment")
//   ];
//   return requests;
// }
}
