import 'package:dio/dio.dart';
import 'package:maico_land/model/api/request/news_request.dart';
import 'package:maico_land/model/entities/data_local_info.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/local/pref.dart';
import 'package:maico_land/model/repositories/session_repository.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import '/model/api/dio_provider.dart';

class NewsRepository {
  final DioProvider _dioProvider = DioProvider();
  final UserRepository _userRepo = UserRepository();
  final SessionRepository _sessionRepo = SessionRepository(pref: LocalPref());
  Future<bool> create(NewsRequest news) async {
    try {
      String userId = await _userRepo.getUserId();
      Response newsResponse =
          await _dioProvider.dio.post(_dioProvider.createNewsApi,
              data: {
                "title": news.title,
                "content": news.content,
                "hashTags": news.hashTags,
                "imageUrl": news.imageUrl,
                "createBy": userId,
                "type": news.type
              },
              options: Options(headers: {"Content-Type": "application/json"}));
      return Future<bool>.value(true);
    } catch (e) {
      return Future<bool>.value(false);
    }
  }

  Future<List<News>> getHomeNews() async {
    Response response = await _dioProvider.dio.get(
        _dioProvider.getNewsPagination,
        queryParameters: {'pageNumber': 1, 'pageSize': 5});

    var json = response.data;
    List<News> result = [];
    for (int i = 0; i < json.length; i++) {
      var news = News.fromMap(json[i]);
      result.add(news);
    }
    return Future<List<News>>.value(result);
  }

  Future<List<News>> getNewsPagination(
      int pageNumber, int pageSize, String key) async {
    Response response;
    if (key == "") {
      response = await _dioProvider.dio.get(_dioProvider.getNewsPagination,
          queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize});
    } else {
      response = await _dioProvider.dio
          .get(_dioProvider.searchNews, queryParameters: {'searchKey': key});
    }
    var json = response.data;
    List<News> result = [];
    for (int i = 0; i < json.length; i++) {
      var news = News.fromMap(json[i]);
      result.add(news);
    }
    // print(News.fromMap(json[0]));
    return Future<List<News>>.value(result);
  }

  Future<bool> likeNews(String newsId) async {
    try {
      var userId = await _userRepo.getUserId();
      Response response = await _dioProvider.dio.get(
          _dioProvider.baseUrl + "api/news/${newsId}/like",
          queryParameters: {'newsId': newsId, 'userId': userId});

      print(response.data);
      return Future<bool>.value(true);
    } catch (e) {
      print(e);
      return Future<bool>.value(false);
    }
  }

  Future saveNews(DataLocalInfo data) async {
    _sessionRepo.cacheNews(data);
    // _sessionRepo.getNews();
  }

  Future<List<DataLocalInfo>?> getNews() async {
    return await _sessionRepo.getNews();
  }
}
