part of 'get_clinic_bloc.dart';

@freezed
class GetClinicState with _$GetClinicState {
  const factory GetClinicState.initial() = _Initial;
  const factory GetClinicState.loading() = _Loading;
  const factory GetClinicState.success(Clinic data) = _Success;
  const factory GetClinicState.error(String message) = _Error;
}
