
import 'package:maico_land/model/api/dio_provider.dart';
import 'package:maico_land/model/entities/data_local_info.dart';
import 'package:maico_land/model/local/pref.dart';

class SessionRepository {
  Pref pref;
  final _dioProvider = DioProvider();

  SessionRepository({required this.pref});

  Future<bool> cacheNews(DataLocalInfo news) async {
    List<String>? list = [];
    try {
      list = await pref.getList(DATA_CONST.CACHE_NEWS);
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
      list?.add(land.toJson());
      var l = list?.toSet();
      return pref.saveList(DATA_CONST.CACHE_LANDPLANNING, l!.toList());
    } catch (e) {
      return await pref
          .saveList(DATA_CONST.CACHE_LANDPLANNING, [land.toJson()]);
    }
  }

  Future<bool> removeLand(DataLocalInfo land) async {
    List<String>? list = [];
    try {
      list = await pref.getList(DATA_CONST.CACHE_LANDPLANNING);
      list?.remove(land.toJson());
      var l = list?.toSet();
      return pref.saveList(DATA_CONST.CACHE_LANDPLANNING, l!.toList());
    } catch (e) {
      return await pref
          .saveList(DATA_CONST.CACHE_LANDPLANNING, [land.toJson()]);
    }
  }

  Future<bool> removeNews(DataLocalInfo news) async {
    List<String>? list = [];
    try {
      list = await pref.getList(DATA_CONST.CACHE_NEWS);
      list?.remove(news.toJson());
      var l = list?.toSet();
      return pref.saveList(DATA_CONST.CACHE_NEWS, l!.toList());
    } catch (e) {
      return await pref.saveList(DATA_CONST.CACHE_NEWS, [news.toJson()]);
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

  Future<List<DataLocalInfo>?> getNews() async {
    List<String>? jsonData = await pref.getList(DATA_CONST.CACHE_NEWS);
    if (jsonData == null) {
      return Future.value(null);
    }
    List<DataLocalInfo>? list = [];
    for (var i in jsonData) {
      list.add(DataLocalInfo.fromJson(i));
    }

    return list;
  }

  Future<List<DataLocalInfo>?> getSavedLand() async {
    List<DataLocalInfo> list = [];
    try {
      List<String>? jsonData =
          await pref.getList(DATA_CONST.CACHE_LANDPLANNING);
      if (jsonData == null) {
        return Future.value(null);
      }
      List<DataLocalInfo>? list = [];
      for (var i in jsonData) {
        list.add(DataLocalInfo.fromJson(i));
      }

      return list;
    } catch (e) {
      return list;
    }
  }

  // Future<TimeSlot> getSelectedTimeSlot() async {
  //   String jsonData = await pref.getString(DATA_CONST.CACHE_SELECTED_TIME_SLOT);
  //   if (jsonData == null) {
  //     return Future.value(null);
  //   }
  //   return TimeSlot.fromJson(json.decode(jsonData));
  // }
}
