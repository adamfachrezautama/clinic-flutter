// ignore_for_file: public_member_api_docs, sort_constructors_first

class ChatDoctorModel {
  final String name;
  final String message;
  final String? spesialis;
  final String time;
  final String avatarUrl;
  final bool isActive;
  final String countMessage;

  ChatDoctorModel({
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
    required this.isActive,
    required this.countMessage,
    this.spesialis,
  });

  
}
