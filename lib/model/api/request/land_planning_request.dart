import 'package:maico_land/model/entities/GeoPoint.dart';
import 'package:maico_land/model/entities/address.dart';

class LandPlanningRequest {
  final String title;
  final String content;
  final String imageUrl;
  final double landArea;
  final String filePdfUrl;
  final DateTime expirationDate;
  final GeoPoint leftTop;
  final GeoPoint rightTop;
  final GeoPoint leftBottom;
  final GeoPoint rightBottom;
  final Address address; 

  LandPlanningRequest(
      this.title,
      this.content,
      this.imageUrl,
      this.address,
      this.landArea,
      this.filePdfUrl,
      this.expirationDate,
      this.leftTop,
      this.rightTop,
      this.leftBottom,
      this.rightBottom);
}
