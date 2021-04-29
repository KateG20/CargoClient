import 'Request.dart';

class Service {

  List<Request> getNewRequests() {

    // ура хардкодим
    var requests = [
      Request("Shipper", "Receiver", DateTime.utc(2021, 3, 8),
          Duration(hours: 3), 120, "ТЛЦ", "Владивосток", 680, "comment"),
      Request("Shipper", "Receiver", DateTime.utc(2021, 7, 1),
          Duration(hours: 1, minutes: 12), 60, "Новосибирск", "ТЛЦ",  680,
          "comment"),
      Request("Shipper", "Receiver", DateTime.utc(2021, 7, 1),
          Duration(hours: 1, minutes: 12), 60, "Новосибирск", "ТЛЦ",  680,
          "comment"),
      Request("Shipper", "Receiver", DateTime.utc(2021, 7, 1),
          Duration(hours: 1, minutes: 12), 60, "Новосибирск", "ТЛЦ",  680,
          "comment"),
      Request("Shipper", "Receiver", DateTime.utc(2021, 7, 1),
          Duration(hours: 1, minutes: 12), 60, "Новосибирск", "ТЛЦ",  680,
          "comment"),
    ];
    return requests;
  }
}