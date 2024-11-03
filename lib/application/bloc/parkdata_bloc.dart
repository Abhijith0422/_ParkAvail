import 'package:bloc/bloc.dart';
import 'package:book_my_park/domain/models/apimodel/apimodel.dart';
import 'package:book_my_park/domain/models/apimodelrepo.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/failures/failures.dart';

part 'parkdata_event.dart';
part 'parkdata_state.dart';
part 'parkdata_bloc.freezed.dart';

@injectable
class ParkdataBloc extends Bloc<ParkdataEvent, ParkdataState> {
  final ApiModelHazardRepo _hazardsRepo;
  ParkdataBloc(this._hazardsRepo) : super(ParkdataState.initial()) {
    on<_Parkdata>((event, emit) async {
      if (state.parkdata.isNotEmpty) {
        emit(state.copyWith(isLoading: false));
      }
      emit(state.copyWith(isLoading: true, failureOrData: none()));
      final Either<MainFailure, List<Apimodel>> downloadOption =
          await _hazardsRepo.getdata(event.districtname);

      downloadOption.fold(
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
    });
  }
}
