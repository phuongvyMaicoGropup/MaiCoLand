import 'dart:convert';

import 'package:maico_land/model/entities/GeoPoint.dart';
import 'package:maico_land/model/entities/address.dart';

class LandPlanning {
  const LandPlanning(
      {required this.id,
      required this.title,
      required this.content,
      required this.createDate,
      required this.imageUrl,
      required this.filePdfUrl,
      required this.landArea,
      required this.expirationDate,
      required this.createdBy,
      required this.leftTop,
      required this.rightTop,
      required this.likes,
      required this.leftBottom,
      required this.rightBottom,
      required this.address});
  final String id;
  final String title;
  final String content;
  final List<String> likes;
  final DateTime createDate;
  final String imageUrl;
  final String filePdfUrl;
  final double landArea;
  final DateTime expirationDate;
  final String createdBy;
  final GeoPoint leftTop;
  final GeoPoint rightTop;
  final GeoPoint leftBottom;
  final GeoPoint rightBottom;
  final Address address;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createDate': createDate.millisecondsSinceEpoch,
      'imageUrl': imageUrl,
      'filePdfUrl': filePdfUrl,
      'landArea': landArea,
      'expirationDate': expirationDate.millisecondsSinceEpoch,
      'createdBy': createdBy,
      'leftTop': leftTop.toMap(),
      'rightTop': rightTop.toMap(),
      'leftBottom': leftBottom.toMap(),
      'rightBottom': rightBottom.toMap(),
      'address': address.toMap(),
      'likes': likes
    };
  }

  factory LandPlanning.fromMap(Map<String, dynamic> map) {
    return LandPlanning(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      createDate: DateTime.parse(map['createDate']),
      imageUrl: map['imageUrl'] ?? '',
      filePdfUrl: map['filePdfUrl'] ?? '',
      landArea: map['landArea']?.toDouble() ?? 0.0,
      expirationDate: DateTime.parse(map['expirationDate']),
      createdBy: map['createdBy'] ?? '',
      likes: List<String>.from(map['likes']),
      leftTop: GeoPoint.fromMap(map['leftTop']),
      rightTop: GeoPoint.fromMap(map['rightTop']),
      leftBottom: GeoPoint.fromMap(map['leftBottom']),
      rightBottom: GeoPoint.fromMap(map['rightBottom']),
      address: Address.fromMap(map['address']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LandPlanning.fromJson(String source) =>
      LandPlanning.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LandPlanning(id: $id, title: $title, content: $content, createDate: $createDate, imageUrl: $imageUrl, filePdfUrl: $filePdfUrl, landArea: $landArea, expirationDate: $expirationDate, createdBy: $createdBy, leftTop: $leftTop, rightTop: $rightTop, leftBottom: $leftBottom, rightBottom: $rightBottom, address: $address)';
  }

  LandPlanning copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createDate,
    String? imageUrl,
    String? filePdfUrl,
    double? landArea,
    DateTime? expirationDate,
    String? createdBy,
    GeoPoint? leftTop,
    GeoPoint? rightTop,
    GeoPoint? leftBottom,
    GeoPoint? rightBottom,
    Address? address,
    List<String>? likes,
  }) {
    return LandPlanning(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createDate: createDate ?? this.createDate,
      imageUrl: imageUrl ?? this.imageUrl,
      filePdfUrl: filePdfUrl ?? this.filePdfUrl,
      landArea: landArea ?? this.landArea,
      expirationDate: expirationDate ?? this.expirationDate,
      createdBy: createdBy ?? this.createdBy,
      leftTop: leftTop ?? this.leftTop,
      rightTop: rightTop ?? this.rightTop,
      leftBottom: leftBottom ?? this.leftBottom,
      rightBottom: rightBottom ?? this.rightBottom,
      address: address ?? this.address,
      likes: likes ?? this.likes,
    );
  }
}
