part of 'data_bloc.dart';

@freezed
class DataState with _$DataState {
  const factory DataState(
          {required bool isLoading,
          PUserModel? userModel,
          required Option<Either<MainFailure, PUserModel>> datafetchstate}) =
      _DataState;
  factory DataState.initial() =>
      const DataState(isLoading: false, datafetchstate: None());
}
