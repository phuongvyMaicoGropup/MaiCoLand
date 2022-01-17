import 'package:land_app/model/entity/category.dart';
import 'package:land_app/model/entity/land_planning.dart';
import 'package:land_app/model/repository/planning_land_repository.dart';

class HomeRepository {
  List<LandPlanning> landPlannings = []; 
  Future getHomeData() async{
    landPlannings = await PlanningLandRepository().getAll();
    
  }





}