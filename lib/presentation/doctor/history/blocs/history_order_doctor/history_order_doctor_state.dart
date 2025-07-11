part of 'history_order_doctor_bloc.dart';

@freezed
class HistoryOrderDoctorState with _$HistoryOrderDoctorState {
  const factory HistoryOrderDoctorState.initial() = _Initial;
  const factory HistoryOrderDoctorState.loading() = _Loading;
  const factory HistoryOrderDoctorState.error(String message) = _Error;
  const factory HistoryOrderDoctorState.success(OrderResponseModel orders) =
      _Success;
}
