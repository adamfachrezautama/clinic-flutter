import 'dart:async';

import 'package:flutter_clinicapp/data/datasources/agora_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clinicapp/data/models/response/token_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'agora_token_event.dart';
part 'agora_token_state.dart';
part 'agora_token_bloc.freezed.dart';

class AgoraTokenBloc extends Bloc<AgoraTokenEvent, AgoraTokenState> {
  final AgoraRemoteDatasource datasource;

  AgoraTokenBloc(this.datasource) : super(AgoraTokenState.initial()) {
    on<_Token>((event, emit) async {
      emit(AgoraTokenState.loading());

      final result = await datasource.getToken(event.channelName);

      result.fold(
        (l) => emit(AgoraTokenState.error(l)),
        (r) => emit(AgoraTokenState.success(r)),
      );
    });
  }
}
