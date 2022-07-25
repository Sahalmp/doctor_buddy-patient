import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'details_event.dart';
part 'details_state.dart';
part 'details_bloc.freezed.dart';

@injectable
class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsState.initial()) {
    on<GetGender>((event, emit) {
      emit(state.copyWith(gender: event.gender));
    });
    on<GetDate>((event, emit) {
      emit(state.copyWith(date: event.date));
    });
    on<Getimage>((event, emit) {
      emit(state.copyWith(image: event.image));
    });
    on<Gethospital>((event, emit) {
      emit(state.copyWith(hospital: event.hospital));
    });
  }
}
