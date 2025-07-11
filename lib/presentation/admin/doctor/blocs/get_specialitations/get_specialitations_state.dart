part of 'get_specialitations_bloc.dart';

@freezed
class GetSpecialitationsState with _$GetSpecialitationsState {
  const factory GetSpecialitationsState.initial() = _Initial;
  const factory GetSpecialitationsState.loading() = _Loading;
  const factory GetSpecialitationsState.error(String message) = _Error;
  const factory GetSpecialitationsState.success(SpecialitationResponseModel data) =
      _Success;
}
