import 'package:flutter_clinicapp/data/datasources/specialitation_remote_datasource.dart';
import 'package:flutter_clinicapp/data/models/response/specialitation_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_specialitations_event.dart';
part 'get_specialitations_state.dart';
part 'get_specialitations_bloc.freezed.dart';

class GetSpecialitationsBloc
    extends Bloc<GetSpecialitationsEvent, GetSpecialitationsState> {
  final SpecialitationRemoteDatasource datasource;

  GetSpecialitationsBloc(this.datasource)
      : super(const GetSpecialitationsState.initial()) {
    on<_GetSpecialitations>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getSpecialations();
      result.fold((l) => emit(GetSpecialitationsState.error(l)),
          (r) => emit(_Success(r as SpecialitationResponseModel)));
    });
  }
}
