part of 'update_doctor_bloc.dart';

@freezed
class UpdateDoctorState with _$UpdateDoctorState {
  const factory UpdateDoctorState.initial() = _Initial;
  const factory UpdateDoctorState.loading() = _Loading;
  const factory UpdateDoctorState.error(String message) = _Error;
  const factory UpdateDoctorState.success(String message) = _Success;
}
