part of 'details_bloc.dart';

@freezed
class DetailsState with _$DetailsState {
  const factory DetailsState({gender, date, image, hospital, disabledate,wallet,amount,loading}) =
      _DetailsState;
  factory DetailsState.initial() => DetailsState(date: DateTime.now());
}
