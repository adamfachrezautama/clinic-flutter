part of 'chat_expired_bloc.dart';

@freezed
class ChatExpiredEvent with _$ChatExpiredEvent {
  const factory ChatExpiredEvent.started() = _Started;
  const factory ChatExpiredEvent.expired(String channelId) = _Expired;
}
