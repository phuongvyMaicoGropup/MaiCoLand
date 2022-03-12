import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
// import 'package:mime/mime.dart';
// import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class DioProvider {
  get baseUrl => "http://maicogroup.net:3005/";
  // static String baseUrl = "https://localhost:5001";
  get loginApi => baseUrl + "api/user/authenticate";
  get registerApi => baseUrl + "api/user/register";
  get getPresignedApi => baseUrl + "api/file/getpresignedurl";
  get createNewsApi => baseUrl + "api/news/create";

  get getFileUrl => baseUrl + "api/file/getlink";

  // var loginUrl = "https://localhost:5001/api/Users/authenticate";

  final FlutterSecureStorage storage = FlutterSecureStorage();
  final Dio dio = Dio();
  final Uuid uuid = Uuid();

  Future<String> uploadOneImage(String image) async {
    String pathName = "news/" + uuid.v4() + ".png";
    Response response = await dio.get(
      getPresignedApi,
      queryParameters: {'path': pathName, 'contentType': 'image/png'},
    );

    var imageBinding = await File(image).readAsBytes();

    var result = await http.put(Uri.parse(response.data.toString()),
        body: await File(image).readAsBytesSync(),
        headers: {'Content-Type': 'image/png'});
    print(result.request);
    print(result.statusCode);
    return pathName;
  }

  // Future<String> uploadImage(filename, url) async {
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.files.add(
  //    http.MultipartFile.fromBytes(
  //     'file',
  //     File(filename).readAsBytesSync(),
  //     filename: filename.split("/").last
  //     )
  //   );
  //   var res = await request.send();
  //   return res;
  // }
}
