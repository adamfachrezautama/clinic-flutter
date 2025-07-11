
import 'package:flutter_clinicapp/data/datasources/order_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clinicapp/data/models/response/order_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_orders_patient_event.dart';
part 'get_orders_patient_state.dart';
part 'get_orders_patient_bloc.freezed.dart';

class GetOrdersPatientBloc
    extends Bloc<GetOrdersPatientEvent, GetOrdersPatientState> {
  final OrderRemoteDatasource datasource;
  GetOrdersPatientBloc(this.datasource) : super(const _Initial()) {
    on<_GetOrdersPatient>(
      (event, emit) async {
        emit(const _Loading());
        final result = await datasource.getOrdersByPatient();
        result.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_Success(r)),
        );
      },
    );
  }
}
