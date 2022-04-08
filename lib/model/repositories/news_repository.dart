import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
  List<News> parseNews(dynamic responseBody) {
    return responseBody.map<News>((json) => News.fromJson(json)).toList();
  }

  Future<bool> create(NewsRequest news) async {
    try {
      String userId = await _userRepo.getUserId();
      Response newsResponse =
          await _dioProvider.dio.post(_dioProvider.createNewsApi,
              data: {
                "title": news.title,
                "content": news.content,
                "hashTags": news.hashTags,
                "images": news.images,
                "createdBy": userId,
                "type": news.type,
                "isPrivated": news.isPrivated
              },
              options: Options(headers: {"Content-Type": "application/json"}));
      return Future<bool>.value(true);
    } catch (e) {
      return Future<bool>.value(false);
    }
  }

  Future<List<News>> getHomeNews() async {
    try {
      Response response = await _dioProvider.dio.get(
          _dioProvider.getNewsPagination,
          queryParameters: {'pageNumber': 1, 'pageSize': 5});
      return parseNews(response.data);
    } catch (e) {
      return Future<List<News>>.value(null);
    }
  }

  Future<List<News>> getNewsPagination(
      int pageNumber, int pageSize, String key) async {
    try {
      Response response;
      if (key == "") {
        response = await _dioProvider.dio.get(_dioProvider.getNewsPagination,
            queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize});
      } else {
        response = await _dioProvider.dio
            .get(_dioProvider.searchNews, queryParameters: {'searchKey': key});
      }
      return parseNews(response.data);
    } catch (e) {
      return Future<List<News>>.value(null);
    }
  }

  Future<bool> likeNews(String newsId) async {
    try {
      var userId = await _userRepo.getUserId();
      Response response = await _dioProvider.dio.get(
          _dioProvider.baseUrl + "api/news/$newsId/like",
          queryParameters: {'newsId': newsId, 'userId': userId});

      return Future<bool>.value(true);
    } catch (e) {
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

  Future<News> getNewsById(String id) async {
    try {
      Response response = await _dioProvider.dio.get(
        _dioProvider.baseUrl + "api/news/" + id,
      );
      return Future<News>.value(News.fromJson(response.data));
    } catch (e) {
      return Future<News>.value(null);
    }
  }

  Future<List<News>> getNewsByAuthorId(String id) async {
    try {
      Response response = await _dioProvider.dio.get(
        _dioProvider.baseUrl + "api/news/author/" + id,
      );
      return parseNews(response.data);
    } catch (e) {
      return Future<List<News>>.value(null);
    }
  }
}
