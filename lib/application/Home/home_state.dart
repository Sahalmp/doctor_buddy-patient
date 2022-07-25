part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required int index,
    required int sec,
    required bool enabled,
    required bool loading,
  }) = _HomeState;
  factory HomeState.initial() => const HomeState(
        loading: false,
        enabled: false,
        index: 1,
        sec: 60,
      );
}
