part of 'history_order_doctor_bloc.dart';

@freezed
class HistoryOrderDoctorEvent with _$HistoryOrderDoctorEvent {
  const factory HistoryOrderDoctorEvent.started() = _Started;
  const factory HistoryOrderDoctorEvent.getOrder() = _GetOrder;
}
