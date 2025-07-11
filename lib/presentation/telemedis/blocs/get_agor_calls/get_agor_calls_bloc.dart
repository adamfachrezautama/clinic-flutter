import 'package:flutter_clinicapp/data/datasources/agora_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clinicapp/data/models/response/agora_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_agor_calls_event.dart';
part 'get_agor_calls_state.dart';
part 'get_agor_calls_bloc.freezed.dart';

class GetAgorCallsBloc extends Bloc<GetAgorCallsEvent, GetAgorCallsState> {
  final AgoraRemoteDatasource datasource;

  GetAgorCallsBloc(this.datasource) : super(const GetAgorCallsState.initial()) {
    on<_GetAgorCalls>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getAgoraCalls();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
