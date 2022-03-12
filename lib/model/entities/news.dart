import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class News {

  const News(
     this.id,
     this.title,
     this.content,
     this.hashTags,
     this.imageUrl,
     this.likes,
     this.createDate,
     this.createdBy,
     this.updateDate
  );
  final String id;
  final String title;
  final String content;
  final List<String> hashTags;
  final String imageUrl;
  final List<String> likes;
  final DateTime createDate;
  final String createdBy;
  final DateTime updateDate;


  News copyWith({
    String? id,
    String? title,
    String? content,
    List<String>? hashTags,
    String? imageUrl,
    List<String>? likes,
    DateTime? createDate,
    String? createdBy,
    DateTime? updateDate,
  }) {
    return News(
      id ?? this.id,
      title ?? this.title,
      content ?? this.content,
      hashTags ?? this.hashTags,
      imageUrl ?? this.imageUrl,
      likes ?? this.likes,
      createDate ?? this.createDate,
      createdBy ?? this.createdBy,
      updateDate ?? this.updateDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'hashTags': hashTags,
      'imageUrl': imageUrl,
      'likes': likes,
      'createDate': createDate.millisecondsSinceEpoch,
      'createdBy': createdBy,
      'updateDate': updateDate.millisecondsSinceEpoch,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      map['id'] ?? '',
      map['title'] ?? '',
      map['content'] ?? '',
      List<String>.from(map['hashTags']),
      map['imageUrl'] ?? '',
      List<String>.from(map['likes']),
      DateTime.fromMillisecondsSinceEpoch(map['createDate']),
      map['createdBy'] ?? '',
      DateTime.fromMillisecondsSinceEpoch(map['updateDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory News.fromJson(String source) => News.fromMap(json.decode(source));

  @override
  String toString() {
    return 'News(id: $id, title: $title, content: $content, hashTags: $hashTags, imageUrl: $imageUrl, likes: $likes, createDate: $createDate, createdBy: $createdBy, updateDate: $updateDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return other is News &&
      other.id == id &&
      other.title == title &&
      other.content == content &&
      listEquals(other.hashTags, hashTags) &&
      other.imageUrl == imageUrl &&
      listEquals(other.likes, likes) &&
      other.createDate == createDate &&
      other.createdBy == createdBy &&
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
      updateDate.hashCode;
  }
}
