part of 'get_agor_calls_bloc.dart';

@freezed
class GetAgorCallsEvent with _$GetAgorCallsEvent {
  const factory GetAgorCallsEvent.started() = _Started;
  const factory GetAgorCallsEvent.getAgorCalls() = _GetAgorCalls;
}
