part of 'xendit_callback_bloc.dart';

@freezed
class XenditCallbackState with _$XenditCallbackState {
  const factory XenditCallbackState.initial() = _Initial;
  const factory XenditCallbackState.loading() = _Loading;
  const factory XenditCallbackState.success(String message) = _Success;
  const factory XenditCallbackState.error(String message) = _Error;
}
