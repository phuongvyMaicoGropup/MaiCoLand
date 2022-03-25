import 'dart:convert';

import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/local/pef.dart';

class SessionRepository {
  Pref pref;

  SessionRepository({required this.pref});

  Future<bool> cacheNews(News news) {
    return pref.saveString(DATA_CONST.CACHE_NEWS, news.toJson());
  }

  // Future<bool> cacheShow(Show show) {
  //   return pref.saveString(DATA_CONST.CACHE_SHOW, json.encode(show.toJson()));
  // }

  // Future<bool> cacheSelectedTimeSlot(TimeSlot timeSlot) {
  //   return pref.saveString(
  //       DATA_CONST.CACHE_SELECTED_TIME_SLOT, json.encode(timeSlot.toJson()));
  // }

  // Future<BookTimeSlot> getBookTimeSlot() async {
  //   String jsonData = await pref.getString(DATA_CONST.CACHE_BOOK_TIME_SLOT);
  //   if (jsonData == null) {
  //     return Future.value(null);
  //   }
  //   return BookTimeSlot.fromJson(json.decode(jsonData));
  // }

  Future<News?> getNews() async {
    String jsonData = await pref.getString(DATA_CONST.CACHE_NEWS);
    if (jsonData == null) {
      return Future.value(null);
    }
    return News.fromJson(jsonData);
  }

  // Future<TimeSlot> getSelectedTimeSlot() async {
  //   String jsonData = await pref.getString(DATA_CONST.CACHE_SELECTED_TIME_SLOT);
  //   if (jsonData == null) {
  //     return Future.value(null);
  //   }
  //   return TimeSlot.fromJson(json.decode(jsonData));
  // }
}
