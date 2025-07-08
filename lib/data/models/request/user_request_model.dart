import 'dart:convert';

class UserRequestModel {
  final String name;
  final String address;
  final String birthDate;
  final String gender;
  final String phoneNumber;

  UserRequestModel({
    required this.name,
    required this.address,
    required this.birthDate,
    required this.gender,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'birth_date': birthDate,
      'gender': gender,
      'phone_number': phoneNumber,
    };
  }

  factory UserRequestModel.fromMap(Map<String, dynamic> map) {
    return UserRequestModel(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      birthDate: map['birthDate'] ?? '',
      gender: map['gender'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRequestModel.fromJson(String source) =>
      UserRequestModel.fromJson(json.decode(source));
}
