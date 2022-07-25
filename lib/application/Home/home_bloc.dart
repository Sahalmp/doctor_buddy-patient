import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<Getbottomnavbarpage>((event, emit) {
      emit(state.copyWith(index: event.index));
    });
    on<Gettimerseconds>((event, emit) {
      emit(state.copyWith(sec: event.sec));
    });
    on<Getenabledtimer>((event, emit) {
      emit(state.copyWith(enabled: event.enabled));
    });
    on<Getloading>((event, emit) {
      emit(state.copyWith(loading: event.loading));
    });
  }
}
