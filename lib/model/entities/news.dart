import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News extends Equatable {
  const News(
      {required this.viewed,
      required this.saved,
      required this.isPrivated,
      required this.id,
      required this.title,
      required this.content,
      required this.hashTags,
      required this.images,
      required this.likes,
      required this.createdDate,
      required this.createdBy,
      required this.updatedDate,
      required this.type});
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
    return 'News(id: $id, title: $title, content: $content, hashTags: $hashTags, imageUrl: $images, likes: $likes, createdDate: $createdDate, createdBy: $createdBy, updatedDate: $updatedDate)';
  }

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  Map<String, dynamic> toJson() => _$NewsToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        content,
        images,
        likes,
        createdDate,
        createdBy,
        updatedDate,
        type,
        viewed,
        saved,
        isPrivated
      ];
}
