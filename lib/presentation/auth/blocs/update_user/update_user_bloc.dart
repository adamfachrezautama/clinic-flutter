import 'package:flutter_clinicapp/data/datasources/user_remote_datasource.dart';
import 'package:flutter_clinicapp/data/models/request/user_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clinicapp/data/models/response/login_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_user_event.dart';
part 'update_user_state.dart';
part 'update_user_bloc.freezed.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final UserRemoteDatasource datasource;

  UpdateUserBloc(this.datasource) : super(const UpdateUserState.initial()) {
    on<_UpdateUser>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.updateUser(event.model);
      result.fold((l) => emit(UpdateUserState.error(l)),
          (r) => emit(UpdateUserState.success(r)));
    });
  }
}
