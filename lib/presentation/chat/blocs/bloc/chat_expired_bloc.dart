
import 'package:flutter_clinicapp/data/datasources/firebase_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_expired_event.dart';
part 'chat_expired_state.dart';
part 'chat_expired_bloc.freezed.dart';

class ChatExpiredBloc extends Bloc<ChatExpiredEvent, ChatExpiredState> {
  ChatExpiredBloc() : super(const ChatExpiredState.initial()) {
    on<_Expired>((event, emit) async {
      emit(_Loading());
      final result = await FirebaseDatasource.instance
          .isFirstMessageOlderThanOneDay(event.channelId);
      emit(_Success(result));
    });
  }
}
