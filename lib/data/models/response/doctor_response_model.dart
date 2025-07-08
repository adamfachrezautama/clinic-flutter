class DoctorResponseModel {
  final bool? success;
  final String? status;
  final List<DoctorModel>? data;

  DoctorResponseModel({this.success, this.status, this.data});

  factory DoctorResponseModel.fromMap(Map<String, dynamic> json) =>
      DoctorResponseModel(
        success: json["success"],
        status: json["status"],
        data:
            json["data"] == null
                ? []
                : List<DoctorModel>.from(
                  json["data"]!.map((x) => DoctorModel.fromMap(x)),
                ),
      );

  Map<String, dynamic> toMap() => {
    "success": success,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class DoctorModel {
  final int? id;
  final String? name;
  final String? email;
  final String? role;
  final String? googleId;
  final String? ktpNumber;
  final String? birthDate;
  final String? gender;
  final String? phoneNumber;
  final String? address;
  final String? certification;
  final int? telemedicineFee;
  final int? chatFee;
  final String? startTime;
  final String? endTime;
  final int? clinicId;
  final String? image;
  final String? status;
  final ClinicModel? clinic;
  final SpecialitationModel? specialitaion;

  DoctorModel({
    this.address,
    this.certification,
    this.telemedicineFee,
    this.chatFee,
    this.startTime,
    this.endTime,
    this.clinicId,
    this.image,
    this.status,
    this.clinic,
    this.specialitaion,
    this.id,
    this.name,
    this.email,
    this.role,
    this.googleId,
    this.ktpNumber,
    this.birthDate,
    this.phoneNumber,
    this.gender,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> json) => DoctorModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
    googleId: json["google_id"],
    ktpNumber: json["ktp_number"],
    birthDate: json["birth_date"],
    gender: json["gender"],
    phoneNumber: json["phoneNumber"],
    address: json["address"],
    certification: json["certification"],
    telemedicineFee: json["telemedicine_fee"],
    chatFee: json["chat_fee"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    clinicId: json["clinic_id"],
    image: json["image"],
    status: json["status"],
    clinic: json["clinic"] == null ? null : ClinicModel.fromMap(json["clinic"],),
    specialitaion:
        json["specialitation"] == null
            ? null
            : SpecialitationModel.fromMap(json["specialitation"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "role": role,
    "google_id": googleId,
    "ktp_number": ktpNumber,
    "birth_date": birthDate,
    "gender": gender,
    "phone_number": phoneNumber,
    "address": address,
    "certification": certification,
    "telemedicine_fee": telemedicineFee,
    "chat_fee": chatFee,
    "start_time": startTime,
    "end_time": endTime,
    "clinic_id": clinicId,
    "image": image,
    "status": status,
    "clinic": clinic?.toMap(),
    "specialitation": specialitaion?.toMap(),
  };
}

class ClinicModel {
  final int? id;
  final String? name;
  final String? address;
  final String? phone;
  final String? openTime;
  final String? closeTime;
  final String? specialitation;
  final String? website;
  final String? email;
  final String? note;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ClinicModel({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.openTime,
    this.closeTime,
    this.specialitation,
    this.website,
    this.email,
    this.note,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory ClinicModel.fromMap(Map<String, dynamic> json) => ClinicModel(
    id:json["id"],
    name: json["name"],
    address: json["address"],
    phone: json["phone"],
    openTime: json["open_time"],
    closeTime: json["close_time"],
    specialitation: json["specialitation"],
    website: json["website"],
    email: json["email"],
    note:json["note"],
    image:json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name":name,
    "address":address,
    "phone":phone,
    "open_time":openTime,
    "close_time":closeTime,
    "specialistation":specialitation,
    "website":website,
    "email":email,
    "note":note,
    "image":image,
    "created_at":createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
