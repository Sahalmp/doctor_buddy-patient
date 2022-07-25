part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.initialize() = Initialize;
  const factory HomeEvent.getbottomnavbarpage({required int index}) =
      Getbottomnavbarpage;
  const factory HomeEvent.gettimerseconds({required int sec}) = Gettimerseconds;
  const factory HomeEvent.getenabledtimer({required bool enabled}) =
      Getenabledtimer;
  const factory HomeEvent.getloading({required bool loading}) = Getloading;
}
