part of 'get_doctors_bloc.dart';

@freezed
class GetDoctorsState with _$GetDoctorsState {
  const factory GetDoctorsState.initial() = _Initial;
  const factory GetDoctorsState.loading() = _Loading;
  const factory GetDoctorsState.success(List<DoctorModel> doctors) = _Success;
  const factory GetDoctorsState.error(String message) = _Error;
}
