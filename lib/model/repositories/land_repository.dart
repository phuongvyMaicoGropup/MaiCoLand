import 'package:dio/dio.dart';
import 'package:maico_land/model/api/dio_provider.dart';
import 'package:maico_land/model/api/request/land_planning_request.dart';
import 'package:maico_land/model/repositories/user_repository.dart';

class LandPlanningRepository {
  final DioProvider _dioProvider = DioProvider();
  final UserRepository _userRepo = UserRepository();

  Future<bool> create(LandPlanningRequest news) async {
    String userId = await _userRepo.getUserId();
    // Response newsResponse =
    //     await _dioProvider.dio.post(_dioProvider.createNewsApi,
    //         data: {
    //           "title": news.title,
    //           "content": news.content,
    //           "hashTags": news.hashTags,
    //           "imageUrl": news.imageUrl,
    //           "createBy": userId
    //         },
    //         options: Options(headers: {"Content-Type": "application/json"}));
    return Future<bool>.value(true);
    // if (newsResponse.statusCode == 200) {
    // } else {
    //   return Future<bool>.value(false);
    // }
  }
}
