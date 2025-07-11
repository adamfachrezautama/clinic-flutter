part of 'get_orders_patient_bloc.dart';

@freezed
class GetOrdersPatientState with _$GetOrdersPatientState {
  const factory GetOrdersPatientState.initial() = _Initial;
  const factory GetOrdersPatientState.loading() = _Loading;
  const factory GetOrdersPatientState.success(OrderResponseModel data) =
      _Success;
  const factory GetOrdersPatientState.error(String message) = _Error;
}
