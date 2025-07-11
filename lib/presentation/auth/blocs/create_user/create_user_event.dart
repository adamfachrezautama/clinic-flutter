part of 'create_user_bloc.dart';

@freezed
class CreateUserEvent with _$CreateUserEvent {
  const factory CreateUserEvent.started() = _Started;
  const factory CreateUserEvent.createUser(CreateUserRequestModel model) =
      _CreateUser;
}
