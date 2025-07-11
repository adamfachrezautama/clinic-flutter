part of 'get_doctors_bloc.dart';

@freezed
class GetDoctorsEvent with _$GetDoctorsEvent {
  const factory GetDoctorsEvent.started() = _Started;
  const factory GetDoctorsEvent.getDoctors() = _GetDoctors;
}
