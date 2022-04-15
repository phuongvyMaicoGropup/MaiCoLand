import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News extends Equatable {
  const News({
    required this.id,
    required this.title,
    required this.content,
    required this.hashTags,
    required this.images,
    required this.likes,
    required this.createdDate,
    required this.createdBy,
    required this.type,
    required this.updatedDate,
    required this.viewed,
    required this.saved,
    required this.isPrivated,
  });
  final String id;
  final String title;
  final String content;
  final List<String>? hashTags;
  final List<String>? images;
  final List<String>? likes;
  final DateTime createdDate;
  final String createdBy;
  final int type;
  final DateTime updatedDate;
  final int viewed;
  final int saved;
  final bool isPrivated;

  @override
  String toString() {
    return 'News(id: $id, title: $title, content: $content, hashTags: $hashTags, images: $images, likes: $likes, createdDate: $createdDate, createdBy: $createdBy, type: $type, updatedDate: $updatedDate, viewed: $viewed, saved: $saved, isPrivated: $isPrivated)';
  }

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      title,
      content,
      hashTags!,
      images!,
      likes!,
      createdDate,
      createdBy,
      type,
      updatedDate,
      viewed,
      saved,
      isPrivated,
    ];
  }

  News copyWith({
    String? id,
    String? title,
    String? content,
    List<String>? hashTags,
    List<String>? images,
    List<String>? likes,
    DateTime? createdDate,
    String? createdBy,
    int? type,
    DateTime? updatedDate,
    int? viewed,
    int? saved,
    bool? isPrivated,
  }) {
    return News(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      hashTags: hashTags ?? this.hashTags,
      images: images ?? this.images,
      likes: likes ?? this.likes,
      createdDate: createdDate ?? this.createdDate,
      createdBy: createdBy ?? this.createdBy,
      type: type ?? this.type,
      updatedDate: updatedDate ?? this.updatedDate,
      viewed: viewed ?? this.viewed,
      saved: saved ?? this.saved,
      isPrivated: isPrivated ?? this.isPrivated,
    );
  }
}
