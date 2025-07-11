
import 'package:flutter_clinicapp/data/datasources/user_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_user_event.dart';
part 'check_user_state.dart';
part 'check_user_bloc.freezed.dart';

class CheckUserBloc extends Bloc<CheckUserEvent, CheckUserState> {
  final UserRemoteDatasource datasource;
  CheckUserBloc(this.datasource) : super(const CheckUserState.initial()) {
    on<_CheckUser>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.checkUser(event.email);
      result.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
