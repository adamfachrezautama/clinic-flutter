part of 'inactive_orders_bloc.dart';

@freezed
class InactiveOrdersState with _$InactiveOrdersState {
  const factory InactiveOrdersState.initial() = _Initial;
  const factory InactiveOrdersState.loading() = _Loading;
  const factory InactiveOrdersState.success(OrderResponseModel data) = _Success;
  const factory InactiveOrdersState.error(String message) = _Error;
}
