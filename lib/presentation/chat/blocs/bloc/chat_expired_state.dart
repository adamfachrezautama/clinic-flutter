part of 'chat_expired_bloc.dart';

@freezed
class ChatExpiredState with _$ChatExpiredState {
  const factory ChatExpiredState.initial() = _Initial;
  const factory ChatExpiredState.loading() = _Loading;
  const factory ChatExpiredState.success(bool isExpired) = _Success;
}
