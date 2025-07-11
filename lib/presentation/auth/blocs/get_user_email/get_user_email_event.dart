part of 'get_user_email_bloc.dart';

@freezed
class GetUserEmailEvent with _$GetUserEmailEvent {
  const factory GetUserEmailEvent.started() = _Started;
  const factory GetUserEmailEvent.getUserEmail(String email) = _GetUserEmail;
}
