part of 'get_doctors_active_bloc.dart';

@freezed
class GetDoctorsActiveState with _$GetDoctorsActiveState {
  const factory GetDoctorsActiveState.initial() = _Initial;
  const factory GetDoctorsActiveState.loading() = _Loading;
  const factory GetDoctorsActiveState.success(List<DoctorModel> doctors) =
      _Success;
  const factory GetDoctorsActiveState.error(String message) = _Error;
}
