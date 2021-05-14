class User {
  int? id;
  String? login;
  String? password;
  String? name;
  String? licensePlate;
  String? company;
  String? key;

  User(this.id, this.login, this.password, this.name, this.licensePlate, this.company, this.key);

  User.unregistered(this.name, this.licensePlate, this.company, this.key);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['id'], json['login'], json['password'], json['name'],
        json['licensePlate'], json['company'], json['key']);
  }
}
