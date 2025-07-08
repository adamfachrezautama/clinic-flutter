import 'dart:convert';

class CreateUserRequestModel{
  final String? name;
  final String? email;
  final String? role;
  final String? password;

  CreateUserRequestModel({
    this.name,
    this.email,
    this.role,
    this.password,
});

factory CreateUserRequestModel.fromMap(Map<String, dynamic> json) =>
    CreateUserRequestModel(
      name: json["name"],
      email: json["email"],
      role: json["role"],
      password: json["password"],
    );

Map<String, dynamic> toMap() => {
  "name": name,
  "email": email,
  "role": role,
  "password": password,
};

String toJson() => json.encode(toMap());
}