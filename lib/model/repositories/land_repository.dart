import 'package:dio/dio.dart';
import 'package:maico_land/model/api/dio_provider.dart';
import 'package:maico_land/model/api/request/land_planning_request.dart';
import 'package:maico_land/model/entities/data_local_info.dart';
import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/model/local/pref.dart';
import 'package:maico_land/model/repositories/session_repository.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:uuid/uuid.dart';

class LandPlanningRepository {
  final DioProvider _dioProvider = DioProvider();
  final UserRepository _userRepo = UserRepository();
  final _sessionRepo = SessionRepository(pref: LocalPref());

  Future<bool> create(LandPlanningRequest item) async {
    try {
      String userId = await _userRepo.getUserId();
      var id = const Uuid().v4();
      var imagePathDb = await _dioProvider.uploadFile(
          item.imageUrl, "image/png", "land-planning/$id");
      var filePdfPathDb = await _dioProvider.uploadFile(
          item.filePdfUrl, "application/pdf", "land-planning/$id");
      print(item);
      var date = item.expirationDate.toUtc();
      print(date);
      print(item.address);
      Response LandPlanningResponse =
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
                  "idLevel1": item.address.idLevel1.toString(),
                  "idLevel2": item.address.idLevel2.toString(),
                  "idLevel3": item.address.idLevel3.toString(),
                }
              },
              options: Options(headers: {"Content-Type": "application/json"}));

      return Future<bool>.value(true);
    } catch (e) {
      print(e);

      return Future<bool>.value(false);
    }
  }

  Future<LandPlanning> getLandById(String id) async {
    try {
      Response response = await _dioProvider.dio.get(
        _dioProvider.baseUrl + "api/landplanning/" + id,
      );
      print(response.data);

      return Future<LandPlanning>.value(LandPlanning.fromMap(response.data));
    } catch (e) {
      print(e);
      return Future<LandPlanning>.value(null);
    }
  }

  Future<List<LandPlanning>> getHomeLandPlanning() async {
    Response response = await _dioProvider.dio.get(
        _dioProvider.getLandPlanningPagination,
        queryParameters: {'pageNumber': 1, 'pageSize': 5});

    var json = response.data;
    List<LandPlanning> result = [];
    String linkPdf, linkImage;
    LandPlanning land;
    for (int i = 0; i < json.length; i++) {
      land = LandPlanning.fromMap(json[i]);
      result.add(land);
    }
    return Future<List<LandPlanning>>.value(result);
  }

  Future<bool> likeLand(String landId) async {
    try {
      var userId = await _userRepo.getUserId();
      Response response = await _dioProvider.dio.get(
          _dioProvider.baseUrl + "api/landplanning/${landId}/like",
          queryParameters: {'landId': landId, 'userId': userId});

      return Future<bool>.value(true);
    } catch (e) {
      print(e);
      return Future<bool>.value(false);
    }
  }

  Future<List<LandPlanning>> getLandPlanningPagination(
      int pageNumber,
      int pageSize,
      String searchKey,
      String idAddress1,
      String idAddress2) async {
    Response response;
    if (searchKey == "" && idAddress1 == "" && idAddress2 == "") {
      response = await _dioProvider.dio.get(
          _dioProvider.getLandPlanningPagination,
          queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize});
    } else {
      response = await _dioProvider.dio.get(_dioProvider.searchLandPlanning,
          queryParameters: {
            'searchKey': searchKey,
            'idAddress1': idAddress1,
            'idAddress2': idAddress2
          });
    }
    var json = response.data;
    // var a = parsed[0]['hashTags'].toList();
    List<LandPlanning> result = [];
    for (int i = 0; i < json.length; i++) {
      LandPlanning land = LandPlanning.fromMap(json[i]);
      result.add(land);
    }

    return Future<List<LandPlanning>>.value(result);
  }

  Future saveLand(DataLocalInfo data) async {
    _sessionRepo.cacheLand(data);
  }

  Future<List<DataLocalInfo>?> getSavedLand() async {
    return await _sessionRepo.getSavedLand();
  }
}
