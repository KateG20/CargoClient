class Request {
  int? price;
  String? shipper;
  String? receiver;
  DateTime? date;
  Duration? duration;
  int? distance;
  String? from;
  String? to;
  int? weight;
  String? description;

  Request(this.price, this.shipper, this.receiver, this.date, this.duration,
      this.distance, this.from, this.to, this.weight, this.description);

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
        json['price'],
        json['shipper'],
        json['receiver'],
        json['date'],
        json['duration'],
        json['distance'],
        json['from'],
        json['to'],
        json['weight'],
        json['description']);
  }
}
