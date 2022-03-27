import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:maico_land/model/api/dio_provider.dart';
import 'package:maico_land/model/entities/data_local_info.dart';
import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/local/pref.dart';

class SessionRepository {
  Pref pref;
  final _dioProvider = DioProvider();

  SessionRepository({required this.pref});

  Future<bool> cacheNews(DataLocalInfo news) async {
    List<String>? list = [];
    try {
      list = await pref.getList(DATA_CONST.CACHE_NEWS);
      print(list);
      list?.add(news.toJson());
      var l = list?.toSet();
      return pref.saveList(DATA_CONST.CACHE_NEWS, l!.toList());
    } catch (e) {
      return await pref.saveList(DATA_CONST.CACHE_NEWS, [news.toJson()]);
    }
  }

  Future<bool> cacheLand(DataLocalInfo land) async {
    List<String>? list = [];
    try {
      list = await pref.getList(DATA_CONST.CACHE_LANDPLANNING);
      print(list);
      list?.add(land.toJson());
      var l = list?.toSet();
      return pref.saveList(DATA_CONST.CACHE_LANDPLANNING, l!.toList());
    } catch (e) {
      return await pref
          .saveList(DATA_CONST.CACHE_LANDPLANNING, [land.toJson()]);
    }
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

  Future<List<News>?> getNews() async {
    List<String>? jsonData = await pref.getList(DATA_CONST.CACHE_NEWS);
    if (jsonData == null) {
      return Future.value(null);
    }
    List<News>? listNews = [];
    Response response;
    for (var i in jsonData) {
      i = DataLocalInfo.fromJson(i).id;
      try {
        response = await _dioProvider.dio.get(
          _dioProvider.baseUrl + "api/news/" + i,
        );
        print(response.data);

        listNews.add(News.fromMap(response.data));
      } catch (e) {
        print(e);
        return listNews;
      }
    }
    return listNews;
  }

  Future<List<LandPlanning>?> getSavedLand() async {
    List<String>? jsonData = await pref.getList(DATA_CONST.CACHE_LANDPLANNING);
    if (jsonData == null) {
      return Future.value(null);
    }
    List<LandPlanning>? listLand = [];
    Response response;
    for (var i in jsonData) {
      i = DataLocalInfo.fromJson(i).id;
      try {
        response = await _dioProvider.dio.get(
          _dioProvider.baseUrl + "api/landplanning/" + i,
        );
        print(response.data);

        listLand.add(LandPlanning.fromMap(response.data));
      } catch (e) {
        print(e);
        return listLand;
      }
    }
    return listLand;
  }

  // Future<TimeSlot> getSelectedTimeSlot() async {
  //   String jsonData = await pref.getString(DATA_CONST.CACHE_SELECTED_TIME_SLOT);
  //   if (jsonData == null) {
  //     return Future.value(null);
  //   }
  //   return TimeSlot.fromJson(json.decode(jsonData));
  // }
}
