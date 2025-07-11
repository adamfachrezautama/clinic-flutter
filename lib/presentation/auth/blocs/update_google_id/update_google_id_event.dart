part of 'update_google_id_bloc.dart';

@freezed
class UpdateGoogleIdEvent with _$UpdateGoogleIdEvent {
  const factory UpdateGoogleIdEvent.started() = _Started;
  const factory UpdateGoogleIdEvent.updateGoogleId(String googleId, String id) =
      _UpdateGoogleId;
}
