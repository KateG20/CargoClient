class Request {
  DateTime? date;
  Duration? duration;
  int? distance;
  String? from;
  String? to;

  Request(this.date, this.duration, this.distance, this.from, this.to);

// Request.noted(this.date, this.duration, this.distance, from, to) {
//   this.from = "from " + from;
//   this.to = "to " + to;
// }
}