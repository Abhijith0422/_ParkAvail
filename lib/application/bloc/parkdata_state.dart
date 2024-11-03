part of 'parkdata_bloc.dart';

@freezed
class ParkdataState with _$ParkdataState {
  const factory ParkdataState({
    required bool isLoading,
    required List<Apimodel> parkdata,
    required Option<Either<MainFailure, List<Apimodel>>> failureOrData,
  }) = _ParkdataState;

  factory ParkdataState.initial() {
    return const ParkdataState(
      isLoading: false,
      parkdata: [],
      failureOrData: None(),
    );
  }
}
