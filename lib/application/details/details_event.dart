part of 'details_bloc.dart';

@freezed
class DetailsEvent with _$DetailsEvent {
  const factory DetailsEvent.initialize() = _Initialize;
  const factory DetailsEvent.getgender({gender}) = GetGender;
  const factory DetailsEvent.getdate({date}) = GetDate;
  const factory DetailsEvent.getimage({image}) = Getimage;
  const factory DetailsEvent.gethospital({hospital}) = Gethospital;
}
