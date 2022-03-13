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

  Future<List<News>> getNewsPagination(int pageNumber, int pageSize) async {
    Response response = await _dioProvider.dio.get(
        _dioProvider.getNewsPagination,
        queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize});

    var json = response.data;
    print(json[0]['hashTags']);
    // var a = parsed[0]['hashTags'].toList();
    List<News> result = [];
    for (int i = 0; i < json.length; i++) {
      List<String> hashTags = [];
      for (int j = 0; j < json[i]['hashTags'].length; j++) {
        hashTags.add(json[i]['hashTags'][j]);
      }
      var link = await _dioProvider.getFileLink(json[i]['imageUrl']);

      var news = News(
          id: json[i]["id"],
          title: json[i]["title"],
          content: json[i]["content"],
          hashTags: hashTags,
          imageUrl: link,
          likes: json[i]["likes"],
          createDate: DateTime.parse(json[i]["createDate"]),
          createdBy: json[i]["createdBy"],
          updateDate: DateTime.parse(json[i]["updateDate"]));
      result.add(news);
    }
    return Future<List<News>>.value(result);
  }
}
