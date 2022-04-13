import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/land_repository.dart';
import 'package:maico_land/model/repositories/news_repository.dart';

class HomeRepository {
  List<String> landPlannings = [];
  List<String> news = [];
  Future getHomeData() async {
    // landPlannings = await PlanningLandRepository().getHomeLand();
    news = await NewsRepository().getHomeNews();
    landPlannings = await LandPlanningRepository().getHomeLandPlanning();
  }
}
