import 'package:land_app/model/entity/land_planning.dart';
import 'package:land_app/model/entity/news.dart';

class HomeResponse{
  List<LandPlanning> landPlannings;
  List<News> news; 
  HomeResponse({required this.landPlannings, required this.news});
}