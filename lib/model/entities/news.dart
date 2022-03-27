import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class News extends Equatable {
  const News(
      {required this.id,
      required this.title,
      required this.content,
      required this.hashTags,
      required this.imageUrl,
      required this.likes,
      required this.createDate,
      required this.createdBy,
      required this.updateDate,
      required this.type});
  final String id;
  final String title;
  final String content;
  final List<String>? hashTags;
  final String imageUrl;
  final List<String>? likes;
  final DateTime createDate;
  final String createdBy;
  final int type;
  final DateTime updateDate;
  News copyWith(
      {String? id,
      String? title,
      String? content,
      List<String>? hashTags,
      String? imageUrl,
      List<String>? likes,
      DateTime? createDate,
      String? createdBy,
      DateTime? updateDate,
      int? type}) {
    return News(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      hashTags: hashTags ?? this.hashTags,
      imageUrl: imageUrl ?? this.imageUrl,
      likes: likes ?? this.likes,
      createDate: createDate ?? this.createDate,
      createdBy: createdBy ?? this.createdBy,
      updateDate: updateDate ?? this.updateDate,
      type: type ?? this.type,
    );
  }

  @override
  String toString() {
    return 'News(id: $id, title: $title, content: $content, hashTags: $hashTags, imageUrl: $imageUrl, likes: $likes, createDate: $createDate, createdBy: $createdBy, updateDate: $updateDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is News &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        listEquals(other.hashTags, hashTags) &&
        other.imageUrl == imageUrl &&
        listEquals(other.likes, likes) &&
        other.createDate == createDate &&
        other.createdBy == createdBy &&
        other.type == type &&
        other.updateDate == updateDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        hashTags.hashCode ^
        imageUrl.hashCode ^
        likes.hashCode ^
        createDate.hashCode ^
        createdBy.hashCode ^
        type.hashCode ^
        updateDate.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'hashTags': hashTags.toString(),
      'imageUrl': imageUrl,
      'likes': likes.toString(),
      'createDate': createDate.toString(),
      'createdBy': createdBy,
      'updateDate': updateDate.toString(),
      'type': type.toString(),
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    print("hehe");
    return News(
        id: map['id'] ?? '',
        title: map['title'] ?? '',
        content: map['content'] ?? '',
        hashTags: List<String>.from(['hashTags']),
        imageUrl: map['imageUrl'] ?? '',
        likes: List<String>.from(map['likes']),
        createDate: DateTime.parse(map['createDate']),
        createdBy: map['createdBy'] ?? '',
        updateDate: DateTime.parse(map['updateDate']),
        type: map['type']);
  }

  String toJson() => json.encode(toMap());

  factory News.fromJson(String source) => News.fromMap(json.decode(source));

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        content,
        imageUrl,
        likes,
        createDate,
        createdBy,
        updateDate,
        type
      ];
}
