part of 'get_doctors_active_bloc.dart';

@freezed
class GetDoctorsActiveEvent with _$GetDoctorsActiveEvent {
  const factory GetDoctorsActiveEvent.started() = _Started;
  const factory GetDoctorsActiveEvent.getDoctors() = _GetDoctors;
  const factory GetDoctorsActiveEvent.searchDoctors(String query) =
      _SearchDoctors;
  const factory GetDoctorsActiveEvent.spealicationDoctor(int id) =
      _SpealicationDoctor;
  const factory GetDoctorsActiveEvent.fetchAllFromState() = _FetchAllFromState;
}
