class CreateOrderResponseModel{
  final String status;
  final Data data;

  CreateOrderResponseModel({
    required this.status,
    required this.data,
});
  
  factory CreateOrderResponseModel.fromMap(Map<String, dynamic> json) =>
      CreateOrderResponseModel(status: json["status"],
          data: Data.fromMap(json["data"]));

  Map<String, dynamic> toMap()=>{
    "status": status,
    "data":data.toMap(),
  };
  }
class Data{
  final String patientId;
  final String doctorId;
  final String service;
  final String price;
  final String paymentUrl;
  final String status;
  final String duration;
  final String clinicId;
  final DateTime schedule;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Data({
    required this.patientId,
    required this.doctorId,
    required this.service,
    required this.price,
    required this.paymentUrl,
    required this.status,
    required this.duration,
    required this. clinicId,
    required this.schedule,
    required this. updatedAt,
    required this.createdAt,
    required this.id,
});

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    patientId: json["patient_id"],
    doctorId: json["doctor_id"],
    service: json["service"],
    price:json["price"],
    paymentUrl: json["payment_url"],
    status: json["status"],
    duration: json["duration"],
    clinicId: json["clinicId"],
    schedule: DateTime.parse(json["schedule"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toMap() =>{
    "patient_id": patientId,
    "doctor_id": doctorId,
    "service": service,
    "price": price,
    "payment_url":paymentUrl,
    "status": status,
    "duration":duration,
    "clinic_id":clinicId,
    "schedule": schedule.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id":id,
  };
}