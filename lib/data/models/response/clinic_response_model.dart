import 'dart:convert';

class ClinicResponseModel{
  final String status;
  final Clinic data;

  ClinicResponseModel({
    required this.status,
    required this.data
});

  Map<String, dynamic> toMap(){
    return {
      'status': status,
      'data': data.toMap(),
    };
  }

  factory ClinicResponseModel.fromMap(Map<String, dynamic> map){
    return ClinicResponseModel(status: map['status'] ?? '', data: Clinic.fromMap(map['data']),);
  }
}

String toJson() => json.encode(toMap());

class Clinic {
  final String clinicName;
  final int totalDoctor;
  final int totalPatient;
  final String clinicImage;
  final String totalIncome;

  Map<String, dynamic> toMap(){
    return{
      'clinicName': clinicName,
      'totalDoctor': totalDoctor,
      'totalPatient': totalPatient,
      'clinicImage': clinicImage,
      'totalIncome': totalIncome,
    };
  }

  factory Clinic.fromMap(Map<String, dynamic> map){
    return Clinic(
      map['clinic_name'] ?? '',
      map['total_doctor'] ?.toInt() ?? 0,
      map['total_patient']?.toInt() ?? 0,
      map['clinic_image'] ?? '',
      map['total_income'] ?? '0',
    );
  }

  String toJson() => json.encode(toMap());
  factory Clinic.fromJson(String source) => Clinic.fromMap(json.decode(source));

  Clinic(
      this.clinicImage,
      this.clinicName,
      this.totalPatient,
      this.totalDoctor,
      this.totalIncome,
      );
}