import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class News {
  const News(
      {required this.id,
      required this.title,
      required this.content,
      required this.hashTags,
      required this.imageUrl,
      required this.likes,
      required this.createDate,
      required this.createdBy,
      required this.updateDate});
  final String id;
  final String title;
  final String content;
  final List<String> hashTags;
  final String imageUrl;
  final List<String>? likes;
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
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      hashTags: hashTags ?? this.hashTags,
      imageUrl: imageUrl ?? this.imageUrl,
      likes: likes ?? this.likes,
      createDate: createDate ?? this.createDate,
      createdBy: createdBy ?? this.createdBy,
      updateDate: updateDate ?? this.updateDate,
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

  // factory News.fromMap(Map<String, dynamic> map) {
  //   return News(
  //     map['id'] ?? '',
  //     map['title'] ?? '',
  //     map['content'] ?? '',
  //     List<String>.from(map['hashTags']),
  //     map['imageUrl'] ?? '',
  //     List<String>.from(map['likes']),
  //     DateTime.fromMillisecondsSinceEpoch(map['createDate']),
  //     map['createdBy'] ?? '',
  //     DateTime.fromMillisecondsSinceEpoch(map['updateDate']),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  factory News.fromJson(Map<String, dynamic> json) {
    List<String> hashTags = [];
    for (int j = 0; j < json['hashTags'].length; j++) {
      hashTags.add(json['hashTags'][j]);
    }
    List<String> likes = [];
    if (json['likes'] != null) {
      for (int j = 0; j < json['likes'].length; j++) {
        hashTags.add(json['likes'][j]);
      }
    }
    return News(
        id: json["id"] as String,
        title: json["title"] as String,
        content: json["content"] as String,
        hashTags: hashTags,
        imageUrl: json["imageUrl"] as String,
        likes: likes,
        createDate: DateTime.parse(json["createDate"]),
        createdBy: json["createdBy"] as String,
        updateDate: DateTime.parse(json["updateDate"]));
  }

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "title": title,
  //   "likes": likes,
  //   "image": image,
  // };
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
