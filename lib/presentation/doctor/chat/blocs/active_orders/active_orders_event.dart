part of 'active_orders_bloc.dart';

@freezed
class ActiveOrdersEvent with _$ActiveOrdersEvent {
  const factory ActiveOrdersEvent.started() = _Started;
  const factory ActiveOrdersEvent.getOrder(String service, bool isDoctor) =
      _GetOrder;
}
