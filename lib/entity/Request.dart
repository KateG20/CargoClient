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
  int? status;

  Request(
      [this.price,
      this.shipper,
      this.receiver,
      this.date,
      this.duration,
      this.distance,
      this.source,
      this.destination,
      this.weight,
      this.description,
      this.status]);

  Request.optional(
      {this.price,
      this.shipper,
      this.receiver,
      this.date,
      this.duration,
      this.distance,
      this.source,
      this.destination,
      this.weight,
      this.description});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
        json['price'],
        json['shipper'],
        json['receiver'],
        DateTime.fromMillisecondsSinceEpoch(
            json['date'] + DateTime(2020).millisecondsSinceEpoch),
        // millisecondsSinceEpoch
        Duration(minutes: json['duration']),
        // milliseconds
        json['distance'],
        json['source'],
        json['destination'],
        json['weight'],
        json['description'],
        json['status']);
  }
}
