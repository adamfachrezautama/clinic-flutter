import 'dart:convert';

class AgoraRequestModel{
  final int? patientId;
  final int? doctorId;
  final String? channelName;
  final String? callId;

  AgoraRequestModel({
    this.patientId,
    this.doctorId,
    this.channelName,
    this.callId,
});

  factory AgoraRequestModel.fromMap(Map<String, dynamic>  json) =>
      AgoraRequestModel(
        patientId: json["patient_id"],
        doctorId: json["doctor_id"],
        channelName: json["channel_name"],
        callId: json["call_id"],
      );

  Map<String, dynamic> toMap() => {
    "patient_id": patientId,
    "doctor_id": doctorId,
    "channel_name": channelName,
    "call_id": callId,
  };

  String toJson()=> json.encode(toMap());
}