import 'package:flutter/material.dart';

import 'entity/Request.dart';

class ListFilterNotifier extends ValueNotifier<Future<List<Request>>> {
  ListFilterNotifier({Future<List<Request>>? value}) : super(value ?? Future.value([]));
  bool filtered = false;

  void filter(Future<List<Request>> list) {
    value = list;
    filtered = true;
  }

  void reset(Future<List<Request>> list) {
    value = list;
    filtered = false;
  }
}