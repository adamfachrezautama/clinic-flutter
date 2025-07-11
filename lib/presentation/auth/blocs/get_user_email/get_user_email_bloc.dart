import 'package:flutter_clinicapp/data/datasources/user_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clinicapp/data/models/response/login_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_user_email_event.dart';
part 'get_user_email_state.dart';
part 'get_user_email_bloc.freezed.dart';

class GetUserEmailBloc extends Bloc<GetUserEmailEvent, GetUserEmailState> {
  final UserRemoteDatasource datasource;

  GetUserEmailBloc(this.datasource) : super(const GetUserEmailState.initial()) {
    on<_GetUserEmail>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getUserEmail(event.email);
      result.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
