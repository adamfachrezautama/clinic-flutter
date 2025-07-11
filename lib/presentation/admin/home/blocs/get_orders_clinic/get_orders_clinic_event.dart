part of 'get_orders_clinic_bloc.dart';

@freezed
class GetOrdersClinicEvent with _$GetOrdersClinicEvent {
  const factory GetOrdersClinicEvent.started() = _Started;
  const factory GetOrdersClinicEvent.getOrders() = _GetOrders;
}
