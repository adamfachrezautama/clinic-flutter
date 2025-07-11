part of 'inactive_orders_bloc.dart';

@freezed
class InactiveOrdersEvent with _$InactiveOrdersEvent {
  const factory InactiveOrdersEvent.started() = _Started;
  const factory InactiveOrdersEvent.getOrder(String service, bool isDoctor) =
      _GetOrder;
}
