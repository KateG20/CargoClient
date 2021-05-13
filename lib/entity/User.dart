class User {
  int? id;
  String? login;
  String? password;
  String? name;
  String? licensePlate;
  String? company;

  User(this.login, this.password, this.name, this.licensePlate, this.company);

  User.unregistered(this.name, this.licensePlate, this.company);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['login'], json['password'], json['name'],
        json['licensePlate'], json['company']);
  }
}
