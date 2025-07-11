part of 'get_agor_calls_bloc.dart';

@freezed
class GetAgorCallsState with _$GetAgorCallsState {
  const factory GetAgorCallsState.initial() = _Initial;
  const factory GetAgorCallsState.loading() = _Loading;
  const factory GetAgorCallsState.success(AgoraResponseModel model) = _Success;
  const factory GetAgorCallsState.error(String message) = _Error;
}
