import 'dart:convert';

import 'package:land_app/model/entity/news.dart';
import 'package:land_app/model/local/pref.dart';
import 'package:meta/meta.dart';

class SessionRepository {
  Pref pref;

  SessionRepository({required this.pref});

  Future<bool> cacheNews(News news) {
    return pref.saveString(
        DATA_CONST.CACHE_NEWS, json.encode(news.toJson()));
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

  // Future<Show> getShow() async {
  //   String jsonData = await pref.getString(DATA_CONST.CACHE_SHOW);
  //   if (jsonData == null) {
  //     return Future.value(null);
  //   }
  //   return Show.fromJson(json.decode(jsonData));
  // }

  Future<News> getNews() async {
    String jsonData = await pref.getString(DATA_CONST.CACHE_NEWS);
    if (jsonData == null) {
      return Future.value(null);
    }
    return News.fromJson(json.decode(jsonData));
  }
}