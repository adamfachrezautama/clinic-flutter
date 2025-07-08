import 'dart:convert';

import 'package:flutter_clinicapp/data/models/response/user_model.dart';

class LoginResponseModel {
  final String? status;
  final LoginModel? data;
  LoginResponseModel({this.status, this.data});

  Map<String, dynamic> toMap() {
    return {'status': status, 'data': data?.toMap()};
  }

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      status: map['status'],
      data: map['data'] != null ? LoginModel.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromJson(String source) =>
      LoginResponseModel.fromMap(json.decode(source));
}

class LoginModel {
  final String? token;
  final UserModel? user;
  final bool? isNew;

  LoginModel({this.token, this.user, this.isNew});
}

class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? role;
  final String? googleId;
  final String? ktpNumber;
  final DateTime? birthDate;
  final String? gender;
  final String? phoneNumber;
  final String? address;
  final String? certification;
  final String? specialitation;
  final int? telemedicineFee;
  final int? chatFee;
  final String? startTime;
  final String? endTime;
  final int? clinicId;
  final String? image;
  final String? status;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.role,
    this.googleId,
    this.ktpNumber,
    this.birthDate,
    this.gender,
    this.phoneNumber,
    this.address,
    this.certification,
    this.specialitation,
    this.telemedicineFee,
    this.chatFee,
    this.startTime,
    this.endTime,
    this.clinicId,
    this.image,
    this.status,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
    googleId: json["google_id"],
    ktpNumber: json["ktp_number"],
    birthDate: json["birth_datte"] == null ? null : DateTime.parse(json["birth_date"]),
    gender: json["gender"],
    phoneNumber: json["phone_number"],
    address: json["address"],
    certification: json["certification"],
    specialitation: json["specialitation"],
    telemedicineFee: json["telemedicine_fee"],
    chatFee: json["chat_fee"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    clinicId: json["clinic_id"],
    image:json["image"],
    status: json["status"],
  );
  
  Map<String, dynamic> toMap() => {
    "id":id,
    "name":name,
    "email":email,
    "role":role,
    "google_id":googleId,
    "ktp_number": ktpNumber,
    "birth_date":birthDate == null ? null : "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2,'0')}",
    "geder": gender,
    "phone_number": phoneNumber,
    "address": address,
    "certification": certification,
    "specialitation": specialitation,
    "telemedicine_fee": telemedicineFee,
    "chat_fee":chatFee,
    "start_time":startTime,
    "end_time":endTime,
    "clinic_id": clinicId,
    "image":image,
    "status":status,
  };
}
