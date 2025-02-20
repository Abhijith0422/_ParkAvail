import 'package:json_annotation/json_annotation.dart';

part 'apimodel.g.dart';

@JsonSerializable()
class Apimodel {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'location')
  String? location;
  @JsonKey(name: 'lat')
  double? latitude;
  @JsonKey(name: 'lon')
  double? longitude;
  @JsonKey(name: 'price')
  int? price;
  @JsonKey(name: 'availability')
  bool? availability;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'tslots')
  int? tslot;
  @JsonKey(name: 'aslots')
  int? aslot;
  @JsonKey(name: 'description')
  String? description;

  Apimodel(
      {this.name,
      this.price,
      this.availability,
      this.image,
      this.aslot,
      this.tslot,
      this.latitude,
      this.location,
      this.longitude,
      this.description});

  factory Apimodel.fromJson(Map<String, dynamic> json) {
    return _$ApimodelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ApimodelToJson(this);
}
