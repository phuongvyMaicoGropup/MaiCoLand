import 'package:maico_land/model/api/dio_provider.dart';
import 'package:maico_land/model/api/request/news_request.dart';
import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/land_repository.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
import 'package:maico_land/model/repositories/user_repository.dart';

class HomeRepository {
  List<LandPlanning> landPlannings = [];
  List<News> news = [];
  Future getHomeData() async {
    // landPlannings = await PlanningLandRepository().getHomeLand();
    news = await NewsRepository().getHomeNews();
    landPlannings = await LandPlanningRepository().getHomeLandPlanning();
  }
}
