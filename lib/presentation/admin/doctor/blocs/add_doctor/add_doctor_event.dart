part of 'add_doctor_bloc.dart';

import 'package:flutter_clinicapp/data/models/request/doctor_request_model.dart';

@freezed
class AddDoctorEvent with _$AddDoctorEvent{
  const factory AddDoctorEvent.started() = _Started;
  const factory AddDoctorEvent.addDoctor(DoctorRequestModel model) = _AddDoctor;
}