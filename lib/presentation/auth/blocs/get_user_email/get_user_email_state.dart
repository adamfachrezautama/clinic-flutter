part of 'get_user_email_bloc.dart';

@freezed
class GetUserEmailState with _$GetUserEmailState {
  const factory GetUserEmailState.initial() = _Initial;
  const factory GetUserEmailState.loading() = _Loading;
  const factory GetUserEmailState.success(UserModel user) = _Success;
  const factory GetUserEmailState.error(String message) = _Error;
}
