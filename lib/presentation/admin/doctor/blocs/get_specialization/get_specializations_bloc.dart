import 'package:flutter_clinicapp/data/datasources/specialization_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../data/models/response/specialization_response_model.dart';

part 'get_specializations_event.dart';
part 'get_specializations_state.dart';
part 'get_specializations_bloc.freezed.dart';

class GetSpecializationsBloc
    extends Bloc<GetSpecializationsEvent, GetSpecializationsState> {
  final SpecializationRemoteDatasource datasource;

  GetSpecializationsBloc(this.datasource)
      : super(const GetSpecializationsState.initial()) {
    on<_GetSpecializations>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getSpecialations();
      result.fold(
              (l) => emit(GetSpecializationsState.error(l)),
              (r) => emit(_Success(r)));
    });
  }
}
