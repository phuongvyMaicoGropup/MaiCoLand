import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maico_land/model/api/request/news_request.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/model/responses/user_reponse.dart';
import '/model/api/dio_provider.dart';

class NewsRepository {
  final DioProvider _dioProvider = DioProvider();
  final UserRepository _userRepo = UserRepository();

  Future<bool> create(NewsRequest news) async {
    String userId = await _userRepo.getUserId();
    Response newsResponse =
        await _dioProvider.dio.post(_dioProvider.createNewsApi,
            data: {
              "title": news.title,
              "content": news.content,
              "hashTags": news.hashTags,
              "imageUrl": news.imageUrl,
              "createBy": userId
            },
            options: Options(headers: {"Content-Type": "application/json"}));
    return Future<bool>.value(true);
    // if (newsResponse.statusCode == 200) {
    // } else {
    //   return Future<bool>.value(false);
    // }
  }

  Future<List<News>> getHomeNews() async {
    Response response = await _dioProvider.dio.get(
        _dioProvider.getNewsPagination,
        queryParameters: {'pageNumber': 1, 'pageSize': 5});

    var json = response.data;
    List<News> result = [];
    for (int i = 0; i < json.length; i++) {
      var link = await _dioProvider.getFileLink(json[i]['imageUrl']);
      var news = News.fromMap(json[i]);
      news.copyWith(imageUrl: link);
      result.add(news);
    }
    return Future<List<News>>.value(result);
  }

  Future<List<News>> getNewsPagination(int pageNumber, int pageSize) async {
    Response response = await _dioProvider.dio.get(
        _dioProvider.getNewsPagination,
        queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize});

    var json = response.data;
    List<News> result = [];
    for (int i = 0; i < json.length; i++) {
      var link = await _dioProvider.getFileLink(json[i]['imageUrl']);
      var news = News.fromMap(json[i]);
      news.copyWith(imageUrl: link);
      result.add(news);
    }
    // print(News.fromMap(json[0]));
    return Future<List<News>>.value(result);
  }
}
