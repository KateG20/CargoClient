import 'dart:collection';

import 'package:flutter/material.dart';
import 'entity/Request.dart';

class RequestListModel extends ChangeNotifier {
  final List<Request> _allRequests;
  List<Request>? _filteredRequests;

  UnmodifiableListView<Request> get requests =>
      UnmodifiableListView(_filteredRequests!);

  RequestListModel(this._allRequests) {
    _filteredRequests = _allRequests;
  }

  void filter(List<Function> fs) {
    for (int i = 0; i < fs.length; i++) {
      _filteredRequests =
          _filteredRequests?.where((element) => fs[i](element)).toList();
    }
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void reset() {
    _filteredRequests = _allRequests;
    notifyListeners();
  }
}