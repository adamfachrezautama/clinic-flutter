part of 'check_user_bloc.dart';

@freezed
class CheckUserEvent with _$CheckUserEvent {
  const factory CheckUserEvent.started() = _Started;
  const factory CheckUserEvent.checkUser(String email) = _CheckUser;
}
