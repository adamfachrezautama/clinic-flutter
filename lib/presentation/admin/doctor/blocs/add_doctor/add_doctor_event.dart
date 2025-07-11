part of 'add_doctor_bloc.dart';

@freezed
class AddDoctorEvent with _$AddDoctorEvent {
  const factory AddDoctorEvent.started() = _Started;
  const factory AddDoctorEvent.addDoctor(DoctorRequestModel model) = _AddDoctor;
}
