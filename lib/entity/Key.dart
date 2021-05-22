class Key {
  String? value;
  String? name;
  String? licensePlate;
  String? company;

  Key({this.value, this.name, this.licensePlate, this.company});

  factory Key.fromJson(Map<String, dynamic> json) {
    return Key(
        value: json['value'],
        name: json['name'],
        licensePlate: json['licensePlate'],
        company: json['company']);
  }
}
