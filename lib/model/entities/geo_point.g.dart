// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoPoint _$GeoPointFromJson(Map<String, dynamic> json) => GeoPoint(
      (json['longitude'] as num).toDouble(),
      (json['latitude'] as num).toDouble(),
    );

Map<String, dynamic> _$GeoPointToJson(GeoPoint instance) => <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
