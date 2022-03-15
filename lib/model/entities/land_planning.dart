import 'package:equatable/equatable.dart';
import 'package:maico_land/model/entities/GeoPoint.dart';
import 'package:maico_land/model/entities/address.dart';

class LandPlanning extends Equatable {
  LandPlanning(
      {required this.id,
      required this.title,
      required this.content,
      required this.createDate,
      required this.imageUrl,
      required this.filePdfUrl,
      required this.leftTop,
      required this.rightTop,
      required this.leftBottom,
      required this.expirationDate,
      required this.createdBy,
      required this.landArea,
      required this.rightBottom,
      required this.address});
  final String id;
  final String title;
  final String content;
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
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        landArea,
        content,
        title,
        createDate,
        createdBy,
        imageUrl,
        filePdfUrl,
        expirationDate,
        leftTop,
        leftBottom,
        rightTop,
        rightBottom,address
      ];
}
