part of 'delete_doctor_bloc.dart';

@freezed
class DeleteDoctorEvent with _$DeleteDoctorEvent {
  const factory DeleteDoctorEvent.started() = _Started;
  const factory DeleteDoctorEvent.deleteDoctor(String id) = _DeleteDoctor;
}
