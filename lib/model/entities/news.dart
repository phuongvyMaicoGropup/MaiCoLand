import 'dart:convert';

import 'package:equatable/equatable.dart';

class News extends Equatable {
  const News(
      {required this.id,
      required this.title,
      required this.content,
      required this.hashTags,
      required this.imageUrl,
      required this.likes,
      required this.createdBy,
      required this.createDate,
      required this.updateDate});
  final String id;
  final String title;
  final String content;
  final List<String> hashTags;
  final String imageUrl;
  final List<String> likes;
  final DateTime createDate;
  final String createdBy;
  final DateTime updateDate;

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        content,
        hashTags,
        imageUrl,
        likes,
        createDate,
        createdBy,
        updateDate
      ];
}
