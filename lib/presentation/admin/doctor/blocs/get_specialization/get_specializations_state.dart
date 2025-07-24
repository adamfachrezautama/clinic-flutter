part of 'get_specializations_bloc.dart';

@freezed
class GetSpecializationsState with _$GetSpecializationsState {
  const factory GetSpecializationsState.initial() = _Initial;
  const factory GetSpecializationsState.loading() = _Loading;
  const factory GetSpecializationsState.error(String message) = _Error;
  const factory GetSpecializationsState.success(SpecializationResponseModel data) =
      _Success;
}
