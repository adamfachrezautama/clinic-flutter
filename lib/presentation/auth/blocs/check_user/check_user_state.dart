part of 'check_user_bloc.dart';

@freezed
class CheckUserState with _$CheckUserState {
  const factory CheckUserState.initial() = _Initial;
  const factory CheckUserState.loading() = _Loading;
  const factory CheckUserState.success(bool isValid) = _Success;
  const factory CheckUserState.error(String message) = _Error;
}
