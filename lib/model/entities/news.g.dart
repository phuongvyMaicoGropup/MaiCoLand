// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
      viewed: json['viewed'] as int,
      saved: json['saved'] as int,
      isPrivated: json['isPrivated'] as bool,
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      hashTags: (json['hashTags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      likes:
          (json['likes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      createdDate: DateTime.parse(json['createdDate'] as String),
      createdBy: json['createdBy'] as String,
      updatedDate: DateTime.parse(json['updatedDate'] as String),
      type: json['type'] as int,
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'hashTags': instance.hashTags,
      'images': instance.images,
      'likes': instance.likes,
      'createdDate': instance.createdDate.toIso8601String(),
      'createdBy': instance.createdBy,
      'type': instance.type,
      'updatedDate': instance.updatedDate.toIso8601String(),
      'viewed': instance.viewed,
      'saved': instance.saved,
      'isPrivated': instance.isPrivated,
    };
