part of 'get_orders_clinic_bloc.dart';

@freezed
class GetOrdersClinicState with _$GetOrdersClinicState {
  const factory GetOrdersClinicState.initial() = _Initial;
  const factory GetOrdersClinicState.loading() = _Loading;
  const factory GetOrdersClinicState.success(OrderResponseModel orders) =
      _Success;
  const factory GetOrdersClinicState.error(String message) = _Error;
}
