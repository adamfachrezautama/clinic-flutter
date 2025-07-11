import 'package:flutter_clinicapp/data/datasources/doctor_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clinicapp/data/models/response/doctor_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_doctors_event.dart';
part 'get_doctors_state.dart';
part 'get_doctors_bloc.freezed.dart';

class GetDoctorsBloc extends Bloc<GetDoctorsEvent, GetDoctorsState> {
  final DoctorRemoteDatasource datasource;

  GetDoctorsBloc(this.datasource) : super(const GetDoctorsState.initial()) {
    on<_GetDoctors>((event, emit) async {
      final result = await datasource.getDoctors();
      result.fold(
        (l) => emit(GetDoctorsState.error(l)),
        (r) => emit(GetDoctorsState.success(r.data!)),
      );
    });
  }
}
