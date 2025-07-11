part of 'get_specialitations_bloc.dart';

@freezed
class GetSpecialitationsEvent with _$GetSpecialitationsEvent {
  const factory GetSpecialitationsEvent.started() = _Started;
  const factory GetSpecialitationsEvent.getSpecialitations() = _GetSpecialitations;
}
