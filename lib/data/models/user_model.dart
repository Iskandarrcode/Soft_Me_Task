class UserModel {
  final String name;
  final String surname;
  final String userName;
  final String password;

  UserModel({
    required this.name,
    required this.surname,
    required this.userName,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"] ?? "",
      surname: json["surname"] ?? "",
      userName: json["userName"] ?? "",
      password: json["password"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "surname": surname,
      "userName": userName,
      "password": password,
    };
  }
}
