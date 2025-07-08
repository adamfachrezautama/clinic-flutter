import 'dart:convert';

class OrderRequestModel {
  final String? patientId;
  final String? doctorId;
  final String? service;
  final String? price;
  final String? status;
  final String? statusService;
  final String? duration;
  final String? clinicId;
  final DateTime? schedule;

  OrderRequestModel({
    this.patientId,
    this.doctorId,
    this.service,
    this.price,
    this.status,
    this.statusService,
    this.duration,
    this.clinicId,
    this.schedule,
  });

  factory OrderRequestModel.fromMap(Map<String, dynamic> json) =>
      OrderRequestModel(
        patientId: json["patientId"],
        doctorId: json["doctor_id"],
        service: json["service"],
        price: json["price"],
        statusService: json["status_service"],
        status: json["status"],
        duration: json["duration"],
        clinicId: json["clinic_id"],
        schedule: json["schedule"] == null ? null : DateTime.parse(json["schedule"]),
      );
  
  Map<String, dynamic> toMap() => {
    "patient_id": patientId,
    "doctor_id": doctorId,
    "service": service,
    "price":price,
    "status_service": statusService,
    "duration": duration,
    "clinic_id": clinicId,
    "schedule":
        "${schedule!.year.toString().padLeft(4,'0')}-${schedule!.month.toString().padLeft(2, '0')}-${schedule!.day.toString().padLeft(2,'0')}",
  };

  String toJson() => json.encode(toMap());
}
