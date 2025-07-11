part of 'add_agora_call_bloc.dart';

@freezed
class AddAgoraCallState with _$AddAgoraCallState {
  const factory AddAgoraCallState.initial() = _Initial;
  const factory AddAgoraCallState.loading() = _Loading;
  const factory AddAgoraCallState.success(String message) = _Success;
  const factory AddAgoraCallState.error(String message) = _Error;
}
