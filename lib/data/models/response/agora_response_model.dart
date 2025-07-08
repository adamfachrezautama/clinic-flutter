class AgoraResponseModel{
  final bool? success;
  final int? status;
  final List<AgoraModel>? data;

  AgoraResponseModel({
    this.success,
    this.status,
    this.data,
});

  factory AgoraResponseModel.fromMap(Map<String, dynamic> json) =>
      AgoraResponseModel(
        success: json["success"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<AgoraModel>.from(
            json["data"]!.map((x) => AgoraModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
    "success": success,
    "status": status,
    "data":
    data == null ? [] :List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class AgoraModel {
  final int? id;
  final int? patientId;
  final int? doctorId;
  final String? channelName;
  final String? callId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AgoraModel({
    this.id,
    this.patientId,
    this.doctorId,
    this.channelName,
    this.callId,
    this.createdAt,
    this.updatedAt,
});

  factory AgoraModel.fromMap(Map<String, dynamic> json) => AgoraModel(
    id:json["id"],
    patientId:json["patient_id"],
    doctorId: json["doctor_id"],
    channelName:json["channel_name"],
    callId:json["call_id"],
    createdAt:json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id" : id,
    "patient_id" : patientId,
    "doctor_id" : doctorId,
    "channel_name" : channelName,
    "call_id": callId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}