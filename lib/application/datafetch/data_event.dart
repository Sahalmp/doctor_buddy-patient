part of 'data_bloc.dart';

@freezed
class DataEvent with _$DataEvent {
  const factory DataEvent.initialized() = Initialized;
  const factory DataEvent.getdata() = Getdata;
}
