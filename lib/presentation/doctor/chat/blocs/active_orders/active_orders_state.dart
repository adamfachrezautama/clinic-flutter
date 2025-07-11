part of 'active_orders_bloc.dart';

@freezed
class ActiveOrdersState with _$ActiveOrdersState {
  const factory ActiveOrdersState.initial() = _Initial;
  const factory ActiveOrdersState.loading() = _Loading;
  const factory ActiveOrdersState.success(OrderResponseModel data) = _Success;
  const factory ActiveOrdersState.error(String message) = _Error;
}
