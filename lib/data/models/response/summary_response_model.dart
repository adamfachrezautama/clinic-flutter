class SummaryResponseModel{
  final String? status;
  final SummaryModel? data;

  SummaryResponseModel({
    this.status,this.data,
});

  factory SummaryResponseModel.fromMap(Map<String, dynamic> json) =>
      SummaryResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : SummaryModel.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap()=> {
    "status": status,
    "data": data?.toMap(),
  };
}

class SummaryModel{
  final int? orderCount;
  final int? doctorCount;
  final int? patientCount;
  final int? totalIncome;

  SummaryModel({
    this.orderCount,
    this.totalIncome,
    this.doctorCount,
    this.patientCount
});

  factory SummaryModel.fromMap(Map<String, dynamic> json) => SummaryModel(
    orderCount: json["order_count"],
    doctorCount: json["doctor_count"],
    patientCount: json["patient_count"],
    totalIncome: json["total_income"],
  );

  Map<String, dynamic> toMap() => {
    "order_count": orderCount,
    "doctor_count": doctorCount,
    "patient_count": patientCount,
    "total_income": totalIncome,
  };
}