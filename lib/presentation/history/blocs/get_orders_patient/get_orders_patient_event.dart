part of 'get_orders_patient_bloc.dart';

@freezed
class GetOrdersPatientEvent with _$GetOrdersPatientEvent {
  const factory GetOrdersPatientEvent.started() = _Started;
  const factory GetOrdersPatientEvent.getOrdersPatient() = _GetOrdersPatient;
}
