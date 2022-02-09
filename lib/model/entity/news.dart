


import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:land_app/model/entity/app_user.dart';

class News {
  const News({
    required this.dateCreated,
    required this.dateUpdated,
    required this.authorId,
    required this.title,
    required this.content,
    required this.image,
     this.hashTags,
    //  this.user
  });
  final DateTime dateCreated;
  final DateTime dateUpdated;
  final String authorId;
  final String title;
  final String content;
  final String image;
  final List<String>? hashTags;
  // final AppUser? user; 
//

  factory News.fromMap(Map<String, dynamic>? json) {
    if (json == null) {
      throw StateError('missing json for NewsId');
    }
    return News(
        title: json['title'] as String,
        content: json['content'] as String,
        dateCreated: (json['dateCreated'] as Timestamp).toDate(),
        image: json['image'] as String,
        authorId : json['authorId'],
        dateUpdated: (json['dateUpdated'] as Timestamp).toDate(),
        hashTags : json['hashTags']
        );
  }

  Map<String, dynamic> toMap() {
    return {
      'dateCreated': dateCreated.millisecondsSinceEpoch,
      'dateUpdated': dateUpdated.millisecondsSinceEpoch,
      'authorId': authorId,
      'title': title,
      'content': content,
      'image': image,
      'hashTags': hashTags,
    };
  }

  News copyWith({
    DateTime? dateCreated,
    DateTime? dateUpdated,
    String? authorId,
    String? title,
    String? content,
    String? image,
    List<String>? hashTags,
    // AppUser user; 
  }) {
    return News(
      dateCreated: dateCreated ?? this.dateCreated,
      dateUpdated: dateUpdated ?? this.dateUpdated,
      authorId: authorId ?? this.authorId,
      title: title ?? this.title,
      content: content ?? this.content,
      image: image ?? this.image,
      hashTags: hashTags ?? this.hashTags,
      // user : user ?? this.user;
    );
  }


  Map<String, dynamic> toJson() =>  {
      'dateCreated': dateCreated.millisecondsSinceEpoch,
      'dateUpdated': dateUpdated.millisecondsSinceEpoch,
      'authorId': authorId,
      'title': title,
      'content': content,
      'image': image,
      'hashTags': hashTags,
    };

   factory News.fromJson(Map<String,dynamic> json) {
    //  if (json == null) return null;
     return  News( title: json['title']! as String,
        content: json['content']! as String,
        dateCreated: (json['dateCreated']! as Timestamp).toDate(),
        image: json['image']! as String,
        authorId : json['authorId']!,
        dateUpdated: (json['dateUpdated']! as Timestamp).toDate(),
        hashTags : json['hashTags']! as List<String>
   );
   }
       

  @override
  String toString() {
    return 'News(dateCreated: $dateCreated, dateUpdated: $dateUpdated, authorId: $authorId, title: $title, content: $content, image: $image, hashTags: $hashTags)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is News &&
      other.dateCreated == dateCreated &&
      other.dateUpdated == dateUpdated &&
      other.authorId == authorId &&
      other.title == title &&
      other.content == content &&
      other.image == image &&
      listEquals(other.hashTags, hashTags);
  }

  @override
  int get hashCode {
    return dateCreated.hashCode ^
      dateUpdated.hashCode ^
      authorId.hashCode ^
      title.hashCode ^
      content.hashCode ^
      image.hashCode ^
      hashTags.hashCode;
  }
}
