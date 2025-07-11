part of 'agora_token_bloc.dart';

@freezed
class AgoraTokenState with _$AgoraTokenState {
  const factory AgoraTokenState.initial() = _Initial;
  const factory AgoraTokenState.loading() = _Loading;
  const factory AgoraTokenState.success(TokenModel token) = _Success;
  const factory AgoraTokenState.error(String message) = _Error;
}
