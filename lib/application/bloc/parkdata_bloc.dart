<<<<<<< HEAD
// ignore_for_file: unrelated_type_equality_checks

import 'package:bloc/bloc.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
=======
import 'package:bloc/bloc.dart';
import 'package:book_my_park/domain/models/apimodel/apimodel.dart';
import 'package:book_my_park/domain/models/apimodelrepo.dart';
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/failures/failures.dart';
<<<<<<< HEAD
import '../../domain/models/apimodel/apimodel.dart';
import '../../domain/models/apimodelrepo.dart';
=======
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c

part 'parkdata_event.dart';
part 'parkdata_state.dart';
part 'parkdata_bloc.freezed.dart';

@injectable
class ParkdataBloc extends Bloc<ParkdataEvent, ParkdataState> {
  final ApiModelHazardRepo _hazardsRepo;
  ParkdataBloc(this._hazardsRepo) : super(ParkdataState.initial()) {
    on<_Parkdata>((event, emit) async {
<<<<<<< HEAD
      emit(state.copyWith(isLoading: true, failureOrData: none()));
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        emit(
          state.copyWith(
            isLoading: false,
            parkdata: [],
            failureOrData: some(left(MainFailure.clientFailure())),
          ),
        );
        return;
      }

=======
      if (state.parkdata.isNotEmpty) {
        emit(state.copyWith(isLoading: false));
      }
      emit(state.copyWith(isLoading: true, failureOrData: none()));
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
      final Either<MainFailure, List<Apimodel>> downloadOption =
          await _hazardsRepo.getdata(event.districtname);

      downloadOption.fold(
<<<<<<< HEAD
        (failure) => emit(
          state.copyWith(
            parkdata: [],
            isLoading: false,
            failureOrData: some(left(failure)),
          ),
        ),
        (success) => emit(
          state.copyWith(
            isLoading: false,
            parkdata: success,
            failureOrData: some(right(success)),
          ),
        ),
      );
=======
          (failure) => emit(
                state.copyWith(
                  isLoading: false,
                  failureOrData: some(left(failure)),
                ),
              ),
          (success) => emit(state.copyWith(
                isLoading: false,
                parkdata: success,
                failureOrData: some(right(success)),
              )));
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
    });
  }
}
