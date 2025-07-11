part of 'create_user_bloc.dart';

@freezed
class CreateUserState with _$CreateUserState {
  const factory CreateUserState.initial() = _Initial;
  const factory CreateUserState.loading() = _Loading;
  const factory CreateUserState.success(String message) = _Success;
  const factory CreateUserState.error(String message) = _Error;
}
