part of 'create_order_bloc.dart';

@freezed
class CreateOrderEvent with _$CreateOrderEvent {
  const factory CreateOrderEvent.started() = _Started;
  const factory CreateOrderEvent.createOrder(OrderRequestModel model) =
      _CreateOrder;
}
