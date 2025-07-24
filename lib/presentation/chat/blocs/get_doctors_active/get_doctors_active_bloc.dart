import 'package:flutter_clinicapp/data/datasources/doctor_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clinicapp/data/models/response/doctor_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_doctors_active_event.dart';
part 'get_doctors_active_state.dart';
part 'get_doctors_active_bloc.freezed.dart';

class GetDoctorsActiveBloc
    extends Bloc<GetDoctorsActiveEvent, GetDoctorsActiveState> {
  final DoctorRemoteDatasource datasource;
  List<DoctorModel> doctors = [];
  GetDoctorsActiveBloc(this.datasource)
      : super(const GetDoctorsActiveState.initial()) {
    on<_GetDoctors>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getDoctorsActive();
      result.fold(
        (l) => emit(GetDoctorsActiveState.error(l)),
        (r) {
          doctors = r.data!;
          emit(GetDoctorsActiveState.success(r.data!));
        },
      );
    });

    on<_SearchDoctors>((event, emit) async {
      emit(const _Loading());
      final newDoctors = doctors
          .where(
            (element) =>
                element.name!
                    .toLowerCase()
                    .contains(event.query.toLowerCase()) ||
                element.specialization!.name
                    .toLowerCase()
                    .contains(event.query.toLowerCase()),
          )
          .toList();
      emit(_Success(newDoctors));
    });

    on<_SpealicationDoctor>((event, emit) async {
      emit(const _Loading());

      for (var doctor in doctors) {
        print('Doctor: ${doctor.name}, Specialization: ${doctor.specialization}');
      }

      if (event.id == 0) {
        emit(GetDoctorsActiveState.success(doctors));
      } else {
        final newDoctors = doctors
            .where((element) => element.specialization?.id == event.id)
            .toList();
        emit(_Success(newDoctors));
      }
    });

    on<_FetchAllFromState>((event, emit) async {
      emit(const _Loading());
      emit(GetDoctorsActiveState.success(doctors));
    });
  }
}
