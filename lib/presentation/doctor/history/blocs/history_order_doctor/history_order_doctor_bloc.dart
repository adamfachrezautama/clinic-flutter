import 'package:flutter_clinicapp/data/datasources/order_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clinicapp/data/models/response/order_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_order_doctor_event.dart';
part 'history_order_doctor_state.dart';
part 'history_order_doctor_bloc.freezed.dart';

class HistoryOrderDoctorBloc
    extends Bloc<HistoryOrderDoctorEvent, HistoryOrderDoctorState> {
  final OrderRemoteDatasource datasource;
  HistoryOrderDoctorBloc(this.datasource) : super(const _Initial()) {
    on<_GetOrder>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getOrdersByDoctor();
      result.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
