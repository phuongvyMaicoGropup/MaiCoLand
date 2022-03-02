import 'package:equatable/equatable.dart';
import 'package:maico_land/model/entities/GeoPoint.dart';

class LandPlanning extends Equatable {
  LandPlanning(
      {required this.id,
      required this.title,
      required this.content,
      required this.dateCreated,
      required this.isValidated,
      required this.imageUrl,
      required this.leftTop,
      required this.rightTop,
      required this.leftBottom,
      required this.rightBottom});
  final String id;
  final String title;
  final String content;
  final DateTime dateCreated;
  final bool isValidated;
  final String imageUrl;
  final GeoPoint leftTop;
  final GeoPoint rightTop;
  final GeoPoint leftBottom;
  final GeoPoint rightBottom;

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        content,
        dateCreated,
        isValidated,
        imageUrl,
        leftTop,
        leftBottom,
        rightTop,
        rightBottom,
        title
      ];

  @override
  String toString() {
    return 'LandPlanning : { name: $title, content: $content}';
  }

  factory LandPlanning.fromMap(Map<String, dynamic>? data, String documentId) {
    if (data == null) {
      throw StateError('missing data for LandPlanningId: $documentId');
    }
    return LandPlanning(
        id: documentId,
        title: data['title'],
        content: data['content'],
        dateCreated: data['dateCreated'],
        isValidated: data['isValidated'],
        imageUrl: data['imageUrl'],
        leftTop: data['leftTop'],
        rightTop: data['rightTop'],
        leftBottom: data['leftBottom'],
        rightBottom: data['rightBottom']);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'dateCreated': dateCreated,
      'isValidated': isValidated,
      'imageUrl': imageUrl,
      'leftTop': leftTop,
      'rightTop': rightTop,
      'leftBottom': leftBottom,
      'rightBottom': rightBottom,
    };
  }
}
