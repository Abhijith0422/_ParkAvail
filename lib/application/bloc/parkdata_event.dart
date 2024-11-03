part of 'parkdata_bloc.dart';

@freezed
class ParkdataEvent with _$ParkdataEvent {
  const factory ParkdataEvent.getdata(String districtname) = _Parkdata;
}
