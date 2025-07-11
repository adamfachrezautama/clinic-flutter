import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_clinicapp/data/datasources/doctor_remote_datasource.dart';
import 'package:flutter_clinicapp/data/models/request/doctor_request_model.dart';

part 'update_doctor_bloc.freezed.dart';
part 'update_doctor_event.dart';
part 'update_doctor_state.dart';

class UpdateDoctorBloc extends Bloc<UpdateDoctorEvent, UpdateDoctorState> {
  final DoctorRemoteDatasource datasource;
  UpdateDoctorBloc(
    this.datasource,
  ) : super(const UpdateDoctorState.initial()) {
    on<_UpdateDoctor>((event, emit) async {
      emit(const _Loading());
      // final result = await datasource.updateDoctor(event.model);
      // result.fold(
      //   (l) => emit(_Error(l)),
      //   (r) => emit(_Success(r)),
      // );
    });
  }
}
