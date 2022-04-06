import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:maico_land/model/entities/geo_point.dart';
import 'package:maico_land/model/entities/address.dart';

part 'land_planning.g.dart';

@JsonSerializable()
class LandPlanning extends Equatable {
  const LandPlanning(
      {required this.id,
      required this.title,
      required this.content,
      required this.createdDate,
      required this.imageUrl,
      required this.detailInfo,
      required this.area,
      required this.expirationDate,
      required this.createdBy,
      required this.leftTop,
      required this.rightTop,
      required this.updatedDate,
      required this.leftBottom,
      required this.rightBottom,
      required this.address,
      required this.viewed,
      required this.saved,
      required this.isPrivated});
  final String id;
  final String title;
  final String content;
  final DateTime createdDate;
  final DateTime updatedDate;
  final String imageUrl;
  final String detailInfo;
  final double area;
  final DateTime expirationDate;
  final String createdBy;
  final GeoPoint leftTop;
  final GeoPoint rightTop;
  final GeoPoint leftBottom;
  final GeoPoint rightBottom;
  final Address address;
  final int viewed;
  final int saved;
  final bool isPrivated;
  factory LandPlanning.fromJson(Map<String, dynamic> json) =>
      _$LandPlanningFromJson(json);

  Map<String, dynamic> toJson() => _$LandPlanningToJson(this);
  @override
  List<Object?> get props => [
        id,
        title,
        content,
        createdDate,
        updatedDate,
        imageUrl,
        detailInfo,
        area,
        expirationDate,
        createdBy,
        leftBottom,
        leftTop,
        rightTop,
        rightBottom,
        viewed,
        saved,
        isPrivated
      ];
}
