import 'package:maico_land/model/repositories/news_repository.dart';

updateNewsViewd(String id) async {
  await NewsRepository().updateViewed(id);
}
