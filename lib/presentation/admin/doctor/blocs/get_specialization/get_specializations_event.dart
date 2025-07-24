part of 'get_specializations_bloc.dart';


@freezed
class GetSpecializationsEvent with _$GetSpecializationsEvent {
  const factory GetSpecializationsEvent.started() = _Started;
  const factory GetSpecializationsEvent.getSpecializations() = _GetSpecializations;
}

