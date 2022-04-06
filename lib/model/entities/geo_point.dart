import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'geo_point.g.dart';

@JsonSerializable()
class GeoPoint extends Equatable {
  GeoPoint(
    this.longitude,
    this.latitude,
  );
  final double longitude;
  final double latitude;

  GeoPoint copyWith({
    double? longitude,
    double? latitude,
  }) {
    return GeoPoint(
      longitude ?? this.longitude,
      latitude ?? this.latitude,
    );
  }

  factory GeoPoint.fromJson(Map<String, dynamic> json) =>
      _$GeoPointFromJson(json);

  Map<String, dynamic> toJson() => _$GeoPointToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [longitude, latitude];
}
