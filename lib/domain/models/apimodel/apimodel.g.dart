// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apimodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Apimodel _$ApimodelFromJson(Map<String, dynamic> json) => Apimodel(
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toInt(),
      availability: json['availability'] as bool?,
      image: json['image'] as String?,
      aslot: (json['aslots'] as num?)?.toInt(),
      tslot: (json['tslots'] as num?)?.toInt(),
      latitude: (json['lat'] as num?)?.toDouble(),
      location: json['location'] as String?,
      longitude: (json['lon'] as num?)?.toDouble(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ApimodelToJson(Apimodel instance) => <String, dynamic>{
      'name': instance.name,
      'location': instance.location,
      'lat': instance.latitude,
      'lon': instance.longitude,
      'price': instance.price,
      'availability': instance.availability,
      'image': instance.image,
      'tslots': instance.tslot,
      'aslots': instance.aslot,
      'description': instance.description,
    };
