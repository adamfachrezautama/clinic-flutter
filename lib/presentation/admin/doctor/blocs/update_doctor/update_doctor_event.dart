part of 'update_doctor_bloc.dart';

@freezed
class UpdateDoctorEvent with _$UpdateDoctorEvent {
  const factory UpdateDoctorEvent.started() = _Started;
  const factory UpdateDoctorEvent.updateDoctor(DoctorRequestModel model) =
      _UpdateDoctor;
}
