import 'dart:convert';

class SpecialitationResponseModel {
  final String status;
  final List<SpecialitationModel> data;

  SpecialitationResponseModel(this.status, this.data);

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory SpecialitationResponseModel.fromMap(Map<String, dynamic> map) {
    return SpecialitationResponseModel(
      map['status'] ?? '',
      List<SpecialitationModel>.from(
          map['data']?.map((x) => SpecialitationModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SpecialitationResponseModel.fromJson(String source) =>
      SpecialitationResponseModel.fromMap(json.decode(source));
}

class SpecialitationModel {
  final int id;
  final String name;

  SpecialitationModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory SpecialitationModel.fromMap(Map<String, dynamic> map) {
    return SpecialitationModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SpecialitationModel.fromJson(String source) =>
      SpecialitationModel.fromMap(json.decode(source));
}
