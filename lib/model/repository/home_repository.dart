import 'package:land_app/model/entity/category.dart';
import 'package:land_app/model/entity/land_planning.dart';
import 'package:land_app/model/entity/news.dart';
import 'package:land_app/model/repository/news_repository.dart';
import 'package:land_app/model/repository/planning_land_repository.dart';

class HomeRepository {
  List<LandPlanning> landPlannings = []; 
  List<News> news =[];
  Future getHomeData() async{
    landPlannings = await PlanningLandRepository().getHomeLand();
    news = await NewsRepository().getHomeNews();
  }





}