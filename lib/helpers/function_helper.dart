import 'package:maico_land/model/repositories/land_repository.dart';
import 'package:maico_land/model/repositories/news_repository.dart';

updateNewsViewd(String id) async {
  await NewsRepository().updateViewed(id);
}

updateLandViewed(String id) async {
  await LandPlanningRepository().updateViewed(id);
}
