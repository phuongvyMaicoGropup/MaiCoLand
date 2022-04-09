// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'land_planning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LandPlanning _$LandPlanningFromJson(Map<String, dynamic> json) => LandPlanning(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
      imageUrl: json['imageUrl'] as String,
      detailInfo: json['detailInfo'] as String?,
      area: (json['area'] as num).toDouble(),
      expirationDate: DateTime.parse(json['expirationDate'] as String),
      createdBy: json['createdBy'] as String,
      leftTop: GeoPoint.fromJson(json['leftTop'] as Map<String, dynamic>),
      rightTop: GeoPoint.fromJson(json['rightTop'] as Map<String, dynamic>),
      updatedDate: DateTime.parse(json['updatedDate'] as String),
      leftBottom: GeoPoint.fromJson(json['leftBottom'] as Map<String, dynamic>),
      rightBottom:
          GeoPoint.fromJson(json['rightBottom'] as Map<String, dynamic>),
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      viewed: json['viewed'] as int,
      saved: json['saved'] as int,
      isPrivated: json['isPrivated'] as bool,
    );

Map<String, dynamic> _$LandPlanningToJson(LandPlanning instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createdDate': instance.createdDate.toIso8601String(),
      'updatedDate': instance.updatedDate.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'detailInfo': instance.detailInfo,
      'area': instance.area,
      'expirationDate': instance.expirationDate.toIso8601String(),
      'createdBy': instance.createdBy,
      'leftTop': instance.leftTop,
      'rightTop': instance.rightTop,
      'leftBottom': instance.leftBottom,
      'rightBottom': instance.rightBottom,
      'address': instance.address,
      'viewed': instance.viewed,
      'saved': instance.saved,
      'isPrivated': instance.isPrivated,
    };
