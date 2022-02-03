import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class LandPlanning extends Equatable {
  LandPlanning(
      {required this.id,
      required this.title,
      required this.content,
      required this.dateCreated,
      required this.accessToken,
      required this.isValidated,
      required this.mapUrl,
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
  final String mapUrl;
  final String accessToken;
  final String imageUrl;
  final LatLng leftTop;
  final LatLng rightTop;
  final LatLng leftBottom;
  final LatLng rightBottom;

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        content,
        dateCreated,
        isValidated,
        mapUrl,
        accessToken,
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
        accessToken: data['accessToken'],
        isValidated: data['isValidated'],
        mapUrl: data['mapUrl'],
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
      'accessToken': accessToken,
      'isValidated': isValidated,
      'mapUrl': mapUrl,
      'imageUrl': imageUrl,
      'leftTop': leftTop,
      'rightTop': rightTop,
      'leftBottom': leftBottom,
      'rightBottom': rightBottom,
    };
  }
}
