import 'package:flutter_clinicapp/data/datasources/order_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clinicapp/data/models/response/order_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'inactive_orders_event.dart';
part 'inactive_orders_state.dart';
part 'inactive_orders_bloc.freezed.dart';

class InactiveOrdersBloc
    extends Bloc<InactiveOrdersEvent, InactiveOrdersState> {
  final OrderRemoteDatasource datasource;

  InactiveOrdersBloc(this.datasource) : super(const _Initial()) {
    on<_GetOrder>((event, emit) async {
      emit(const _Loading());
      if (event.isDoctor) {
        final result = await datasource.getOrdersByDoctorQuery(
          event.service,
          'Done',
        );
        result.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_Success(r)),
        );
      }
    });
  }
}
