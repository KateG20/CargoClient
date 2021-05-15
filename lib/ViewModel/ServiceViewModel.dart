import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter1/entity/Key.dart';
import 'package:flutter1/entity/Request.dart';
import 'package:flutter1/entity/User.dart';
import 'package:flutter1/service/RequestService.dart';
import 'package:flutter1/service/UserService.dart';

import '../ListFilterNotifier.dart';
import '../LocalUserProvider.dart';
import '../RType.dart';

class ServiceViewModel {
  UserService userService = UserService();
  RequestService requestService = RequestService();

  Future<List<Request>> getRequests(RType type) async {
    switch (type) {
      case RType.news:
        return await requestService.getNewRequests();
      case RType.current:
        return await requestService.getCurrentRequests();
      case RType.archive:
        return await requestService.getArchiveRequests();
    }
  }

  Future<void> refreshList(
      RType type, ListFilterNotifier futureListNotifier) async {
    if (futureListNotifier.filtered) return;
    Future<List<Request>> newList = requestService.getNewRequests();
    // setState(() {
    futureListNotifier.value = newList;
    // });
    // why use newList var? https://stackoverflow.com/a/52992836/2301224
    await Future.delayed(Duration(seconds: 1));
  }

  Future<void> rejectRequest(int requestId, int userId) async {
    await requestService.rejectRequest(requestId, userId);
  }

  Future<void> acceptRequest(int requestId) async {
    await requestService.updateRequestStatus(requestId, 1);
  }

  Future<void> completeRequest(int requestId) async {
    await requestService.updateRequestStatus(requestId, 2);
  }

  Future<void> addRequestToUser(int requestId, int userId) async {
    await requestService.addRequestToUser(requestId, userId);
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
    return await requestService.filterRequests(
        status,
        userId,
        from,
        to,
        dateFrom,
        dateTo,
        minWeight,
        maxWeight,
        minPrice,
        maxPrice,
        minDist,
        maxDist);
  }

  Future<User> createUser(String login, String password) async {
    String encodedPwd = sha256.convert(utf8.encode(password)).toString();
    return await userService
        .createUser(User.create(login, encodedPwd, LocalUserProvider.user));
  }

  Future<User> loginUser(String login, String password) async {
    String encodedPwd = sha256.convert(utf8.encode(password)).toString();

    return await userService.loginUser(login, encodedPwd);
  }

  Future<Key> checkKey(String key) async {
    return await userService.checkKey(key);
  }
}
