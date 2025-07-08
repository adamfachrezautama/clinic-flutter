import 'package:image_picker/image_picker.dart';

class DoctorRequestModel {
  final String name;
  final String email;
  final String role;

  final String status;
  final String gender;
  final String certification;
  final int specialitationId;
  final String telemedicineFee;
  final String chatFee;
  final String startTime;
  final String endTime;
  final String clinicId;

  final XFile? image;

  DoctorRequestModel({
    required this.role,
    required this.status,
    required this.gender,
    required this.certification,
    required this.specialitationId,
    required this.telemedicineFee,
    required this.chatFee,
    required this.startTime,
    required this.endTime,
    required this.clinicId,
    required this.image,
    required this.name,
    required this.email,
  });

  Map<String, String> toMap() => {
    "name": name,
    "email": email,
    "role": role,
    "gender": gender,
    "certification": certification,
    "specialist_id": specialitationId.toString(),
    "telemedicine_fee": telemedicineFee,
    "chat_fee": chatFee,
    "start_time": startTime,
    "end_time": endTime,
    "clinic_id": clinicId,
    "status":status,
  };

  Map<String, String> toUpdateMap() => {
    "name":name,
    "email": email,
    "role": role,
    "gender": gender,
    "certification": certification,
    "specialis_id": specialitationId.toString(),
    "telemedicine_fee": telemedicineFee,
    "chat_fee":chatFee,
    "start_time": startTime,
    "end_time": endTime,
    "clinic_id": clinicId,
    "status":status,
  };
}
