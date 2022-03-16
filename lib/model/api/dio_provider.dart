import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class DioProvider {
  get baseUrl => "http://maicogroup.net:3005/";
  get loginApi => baseUrl + "api/user/authenticate";
  get registerApi => baseUrl + "api/user/register";
  get getPresignedApi => baseUrl + "api/file/getpresignedurl";
  get createNewsApi => baseUrl + "api/news/create";
  get getFileUrl => baseUrl + "api/file/getlink";
  get getNewsPagination => baseUrl + "api/news/read";
  get createLandPlaningApi => baseUrl + "api/landplanning/create";

  final FlutterSecureStorage storage = FlutterSecureStorage();
  final Dio dio = Dio();
  final Uuid uuid = Uuid();

  Future<String> uploadFile(
      String filePath, String contentType, String pathUpload) async {
    String pathName = uuid.v4() + getFileExtension(filePath);
    Response response = await dio.get(
      getPresignedApi,
      queryParameters: {
        'path': "$pathUpload/$pathName",
        'contentType': contentType
      },
    );

    var imageBinding = await File(filePath).readAsBytes();

    var result = await http.put(Uri.parse(response.data.toString()),
        body: await File(filePath).readAsBytesSync(),
        headers: {'Content-Type': contentType});
    return Future<String>.value("$pathUpload/$pathName");
  }

  Future<String> getFileLink(String path) async {
    Response response = await dio.get(
      getFileUrl,
      queryParameters: {'path': path},
    );
    return response.data;
  }

  String getFileExtension(String fileName) {
    return "." + fileName.split('.').last;
  }
}
