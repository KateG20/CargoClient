class Request {
  String? shipper;
  String? receiver;
  DateTime? date;
  Duration? duration;
  int? distance;
  String? from;
  String? to;
  int? weight;
  String? description;

  Request(this.shipper, this.receiver, this.date, this.duration, this.distance,
      this.from, this.to, this.weight, this.description);
}