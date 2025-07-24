import 'dart:convert';

class SpecializationResponseModel {
  final String status;
  final List<SpecializationModel> data;

  SpecializationResponseModel(this.status, this.data);

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory SpecializationResponseModel.fromMap(Map<String, dynamic> map) {
    return SpecializationResponseModel(
      map['status'] ?? '',
      List<SpecializationModel>.from(
          map['data']?.map((x) => SpecializationModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SpecializationResponseModel.fromJson(String source) =>
      SpecializationResponseModel.fromMap(json.decode(source));
}

class SpecializationModel {
  final int id;
  final String name;

  SpecializationModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory SpecializationModel.fromMap(Map<String, dynamic> map) {
    return SpecializationModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SpecializationModel.fromJson(String source) =>
      SpecializationModel.fromMap(json.decode(source));
}
