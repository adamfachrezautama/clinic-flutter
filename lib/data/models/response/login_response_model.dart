import 'dart:convert';

// return response()->json([
//                     'status' => 'success',
//                     'data' => [
//                         'user' => $user,
//                         'is_new' => true,
//                         'token' => $token
//                     ]
//                 ], 201);

class LoginResponseModel {
  final bool status;
  final LoginModel? data;
  LoginResponseModel({
    required this.status,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data?.toMap(),
    };
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

// return response()->json([
//                     'status' => 'success',
//                     'data' => [
//                         'user' => $user,
//                         'is_new' => true,
//                         'token' => $token
//                     ]
//                 ], 201);
class LoginModel {
  final String? token;
  final UserModel? user;
  final bool? isNew;

  LoginModel({
    this.token,
    this.user,
    this.isNew,
  });

  factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
    token: json["token"],
    isNew: json["is_new"],
    user: json["user"] == null ? null : UserModel.fromMap(json["user"]),
  );

  Map<String, dynamic> toMap() => {
    "token": token,
    "user": user?.toMap(),
    "is_new": isNew,
  };
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
  final String? specialization;
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
    this.specialization,
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
    birthDate: json["birth_date"] == null
        ? null
        : DateTime.parse(json["birth_date"]),
    gender: json["gender"],
    phoneNumber: json["phone_number"],
    address: json["address"],
    certification: json["certification"],
    specialization: json["specialization"],
    telemedicineFee: json["telemedicine_fee"],
    chatFee: json["chat_fee"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    clinicId: json["clinic_id"],
    image: json["image"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "role": role,
    "google_id": googleId,
    "ktp_number": ktpNumber,
    "birth_date": birthDate == null
        ? null
        : "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "phone_number": phoneNumber,
    "address": address,
    "certification": certification,
    "specialization": specialization,
    "telemedicine_fee": telemedicineFee,
    "chat_fee": chatFee,
    "start_time": startTime,
    "end_time": endTime,
    "clinic_id": clinicId,
    "image": image,
    "status": status,
  };
}
