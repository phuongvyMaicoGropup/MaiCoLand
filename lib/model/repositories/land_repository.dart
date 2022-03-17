import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:maico_land/model/api/dio_provider.dart';
import 'package:maico_land/model/api/request/land_planning_request.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:uuid/uuid.dart';

class LandPlanningRepository {
  final DioProvider _dioProvider = DioProvider();
  final UserRepository _userRepo = UserRepository();

  Future<bool> create(LandPlanningRequest item) async {
    try {
      String userId = await _userRepo.getUserId();
      var id = Uuid().v4();
      var imagePathDb = await _dioProvider.uploadFile(
          item.imageUrl, "image/png", "land-planning/$id");
      print(imagePathDb);
      var filePdfPathDb = await _dioProvider.uploadFile(
          item.filePdfUrl, "application/pdf", "land-planning/$id");
      print(filePdfPathDb);
      print(item);
      var date = item.expirationDate.toUtc();
      print(date);
      Response newsResponse =
          await _dioProvider.dio.post(_dioProvider.createLandPlaningApi,
              data: {
                "title": item.title,
                "createdBy": userId,
                "content": item.content,
                "imageUrl": imagePathDb,
                "landArea": item.landArea,
                "filePdfUrl": filePdfPathDb,
                "expirationDate": date.toString(),
                "leftTop": {
                  "latitude": item.leftTop.latitude,
                  "longitude": item.leftTop.longitude
                },
                "rightTop": {
                  "latitude": item.rightTop.latitude,
                  "longitude": item.rightTop.longitude
                },
                "leftBottom": {
                  "latitude": item.leftBottom.latitude,
                  "longitude": item.leftBottom.longitude
                },
                "rightBottom": {
                  "latitude": item.rightBottom.latitude,
                  "longitude": item.rightBottom.longitude
                },
                "address": {
                  "idLevel1": item.address.idLevel1,
                  "idLevel2": item.address.idLevel2,
                  "idLevel3": item.address.idLevel3,
                }
              },
              options: Options(headers: {"Content-Type": "application/json"}));

      return Future<bool>.value(true);
    } catch (e) {
      print(e);


      return Future<bool>.value(false);
    }
  }
}
