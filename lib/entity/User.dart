class User {
  int? id;
  String? login;
  String? password;
  String? name;
  String? licensePlate;
  String? company;
  // String? key;

  User.unregistered(this.name, this.licensePlate, this.company);
}