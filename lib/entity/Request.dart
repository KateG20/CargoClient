class Request {
  int? id;
  int? price;
  String? shipper;
  String? receiver;
  DateTime? date;
  Duration? duration;
  int? distance;
  String? source;
  String? destination;
  int? weight;
  String? description;

  Request.withId(
    this.id,
    this.price,
    this.shipper,
    this.receiver,
    this.date,
    this.duration,
    this.distance,
    this.source,
    this.destination,
    this.weight,
    this.description,
  );

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request.withId(
        json['id'],
        json['price'],
        json['shipper'],
        json['receiver'],
        DateTime.fromMillisecondsSinceEpoch(
            json['date'] + DateTime(2020).millisecondsSinceEpoch),
        Duration(minutes: json['duration']),
        json['distance'],
        json['source'],
        json['destination'],
        json['weight'],
        json['description']);
  }
}
