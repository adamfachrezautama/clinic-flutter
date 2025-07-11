part of 'get_clinic_bloc.dart';

@freezed
class GetClinicEvent with _$GetClinicEvent {
  const factory GetClinicEvent.started() = _Started;
  const factory GetClinicEvent.getDetail() = _GetDetail;
}