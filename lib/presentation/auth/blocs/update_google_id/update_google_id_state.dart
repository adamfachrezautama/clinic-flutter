part of 'update_google_id_bloc.dart';

@freezed
class UpdateGoogleIdState with _$UpdateGoogleIdState {
  const factory UpdateGoogleIdState.initial() = _Initial;
  const factory UpdateGoogleIdState.loading() = _Loading;
  const factory UpdateGoogleIdState.success(UserModel user) = _Success;
  const factory UpdateGoogleIdState.error(String message) = _Error;
}
