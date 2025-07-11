import 'package:flutter_clinicapp/data/datasources/order_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clinicapp/data/models/response/order_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_orders_event.dart';
part 'active_orders_state.dart';
part 'active_orders_bloc.freezed.dart';

class ActiveOrdersBloc extends Bloc<ActiveOrdersEvent, ActiveOrdersState> {
  final OrderRemoteDatasource datasource;

  ActiveOrdersBloc(this.datasource) : super(const ActiveOrdersState.initial()) {
    on<_GetOrder>(
      (event, emit) async {
        emit(const _Loading());
        if (event.isDoctor) {
          final result = await datasource.getOrdersByDoctorQuery(
            event.service,
            'Active',
          );

          result.fold(
            (l) => emit(_Error(l)),
            (r) => emit(_Success(r)),
          );
        }
      },
    );
  }
}
