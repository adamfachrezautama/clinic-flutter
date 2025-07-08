import 'login_response_model.dart';

class OrderResponseModel{
  final String? status;
  final List<OrderModel>? data;

  OrderResponseModel({
    this.status,
    this.data,
});
  factory OrderResponseModel.fromMap(Map<String, dynamic> json) =>
      OrderResponseModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<OrderModel>.from(
            json["data"]!.map((x) => OrderModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data":
    data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class OrderModel {
  final int? id;
  final int? patientId;
  final int? doctorId;
  final String? service;
  final int? price;
  final String? paymentUrl;
  final String? status;
  final String? statusService;
  final int? duration;
  final int? clinicId;
  final DateTime? schedule;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserModel? patient;
  final UserModel? doctor;

  OrderModel({
    this.id,
    this.patientId,
    this.doctorId,
    this.service,
    this.price,
    this.paymentUrl,
    this.status,
    this.statusService,
    this.duration,
    this.clinicId,
    this.schedule,
    this.createdAt,
    this.updatedAt,
    this.patient,
    this.doctor,
  });

  factory OrderModel.fromMap(Map<String, dynamic> json) => OrderModel(
    id: json["id"],
    patientId: json["patient_id"],
    doctorId: json["doctor_id"],
    service: json["service"],
    price: json["price"],
    paymentUrl: json["payment_url"],
    status: json["status"],
    statusService: json["status_service"],
    duration: json["duration"],
    clinicId: json["clinic_id"],
    schedule:
    json["schedule"] == null ? null : DateTime.parse(json["schedule"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    patient:
    json["patient"] == null ? null : UserModel.fromMap(json["patient"]),
    doctor:
    json["doctor"] == null ? null : UserModel.fromMap(json["doctor"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "patient_id": patientId,
    "doctor_id": doctorId,
    "service": service,
    "price": price,
    "payment_url": paymentUrl,
    "status": status,
    "status_service": statusService,
    "duration": duration,
    "clinic_id": clinicId,
    "schedule": schedule?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "patient": patient?.toMap(),
    "doctor": doctor?.toMap(),
  };
}
