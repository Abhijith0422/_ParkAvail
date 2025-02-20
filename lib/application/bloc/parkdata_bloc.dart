// ignore_for_file: unrelated_type_equality_checks

import 'package:bloc/bloc.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/failures/failures.dart';
import '../../domain/models/apimodel/apimodel.dart';
import '../../domain/models/apimodelrepo.dart';

part 'parkdata_event.dart';
part 'parkdata_state.dart';
part 'parkdata_bloc.freezed.dart';

@injectable
class ParkdataBloc extends Bloc<ParkdataEvent, ParkdataState> {
  final ApiModelHazardRepo _hazardsRepo;
  ParkdataBloc(this._hazardsRepo) : super(ParkdataState.initial()) {
    on<_Parkdata>((event, emit) async {
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

      final Either<MainFailure, List<Apimodel>> downloadOption =
          await _hazardsRepo.getdata(event.districtname);

      downloadOption.fold(
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
    });
  }
}
