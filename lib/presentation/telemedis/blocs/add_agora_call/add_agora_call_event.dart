part of 'add_agora_call_bloc.dart';

@freezed
class AddAgoraCallEvent with _$AddAgoraCallEvent {
  const factory AddAgoraCallEvent.started() = _Started;
  const factory AddAgoraCallEvent.addAgoraCall(AgoraRequestModel model) =
      _AddAgoraCall;
}
