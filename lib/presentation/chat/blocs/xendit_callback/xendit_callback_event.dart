part of 'xendit_callback_bloc.dart';

@freezed
class XenditCallbackEvent with _$XenditCallbackEvent {
  const factory XenditCallbackEvent.started() = _Started;
  const factory XenditCallbackEvent.callback(String externalId, String status) =
      _Callback;
}
