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
  final String? patientId;
  final String? doctorId;
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



  factory Data.fromMap(Map<String, dynamic> json) {
    try {
      print("DEBUG: Data JSON = ${json.toString()}");

      return Data(
        patientId: json["patient_id"]?.toString(),
        doctorId: json["doctor_id"]?.toString(),
        service: json["service"]?.toString() ?? '',
        price: json["price"]?.toString() ?? '',
        paymentUrl: json["payment_url"]?.toString() ?? '',
        status: json["status"]?.toString() ?? '',
        duration: json["duration"]?.toString() ?? '',
        clinicId: json["clinicId"]?.toString() ?? '',
        schedule: json["schedule"] != null ? DateTime.parse(json["schedule"]) : DateTime.now(),
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : DateTime.now(),
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
        id: json["id"] is int ? json["id"] : int.tryParse(json["id"].toString()) ?? 0,
      );
    } catch (e, stack) {
      print("ERROR parsing Data.fromMap: $e");
      print(stack);
      rethrow;
    }
  }


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