import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:doctorbuddy/domain/datafetch/idatafetch.dart';
import 'package:doctorbuddy/domain/user/usermodel.dart';
import 'package:doctorbuddy/infastructure/datafetch/datafetch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/failures.dart';

part 'data_event.dart';
part 'data_state.dart';
part 'data_bloc.freezed.dart';

@injectable
class DataBloc extends Bloc<DataEvent, DataState> {
  final IDataFetch dataFetch;
  DataBloc(this.dataFetch) : super(DataState.initial()) {
    on<Getdata>((event, emit) async {
      emit(state.copyWith(isLoading: true, datafetchstate: const None()));
      final _result = await dataFetch.getdata();
      final _state = _result.fold(
          (l) => DataState(isLoading: false, datafetchstate: Some(Left(l))),
          (r) => DataState(
              isLoading: true, datafetchstate: Some(right(r)), userModel: r));
      emit(_state);
    });
  }
}
