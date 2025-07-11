import 'package:flutter_clinicapp/data/datasources/user_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clinicapp/data/models/request/create_user_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_user_event.dart';
part 'create_user_state.dart';
part 'create_user_bloc.freezed.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  final UserRemoteDatasource datasource;

  CreateUserBloc(this.datasource) : super(const _Initial()) {
    on<_CreateUser>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.createUser(event.model);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
