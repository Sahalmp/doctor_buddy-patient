import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorbuddy/application/Home/home_bloc.dart';
import 'package:doctorbuddy/presentation/Screens/Login/loginscreen.dart';
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
    on<GetDoctorDate>((event, emit) {
      emit(state.copyWith(disabledate: event.disabledate));
    });
    on<GetWallet>((event, emit) {
      emit(state.copyWith(wallet: event.wallet));
    });
    on<Gettotalamount>((event, emit) {
      emit(state.copyWith(amount: event.amount));
    });
    on<GetLoading>((event, emit) {
      emit(state.copyWith(loading: event.loading));
    });
  }
}
