import 'package:bloc/bloc.dart';
import 'package:flutter_clinicapp/data/models/response/clinic_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_clinicapp/data/datasources/doctor_remote_datasource.dart';

part 'get_clinic_bloc.freezed.dart';
part 'get_clinic_event.dart';
part 'get_clinic_state.dart';

class GetClinicBloc extends Bloc<GetClinicEvent, GetClinicState> {
  final DoctorRemoteDatasource _doctorRemoteDatasource;
  GetClinicBloc(
    this._doctorRemoteDatasource,
  ) : super(_Initial()) {
    on<_GetDetail>((event, emit) async{
      emit(_Loading());
      final result = await _doctorRemoteDatasource.getClinicDetail();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r.data)),
      );
    });
  }
}
