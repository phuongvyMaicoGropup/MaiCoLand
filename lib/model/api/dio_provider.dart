import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class DioProvider {
  get baseUrl => "http://maicogroup.net:3005";
  // static String baseUrl = "https://localhost:5001";
  get loginUrl => "http://maicogroup.net:3005/api/Users/authenticate";
  get registerUrl => "http://maicogroup.net:3005/api/Users/register";
  get getPresignedUrl => "http://maicogroup.net:3005/api/Image/getpresignedurl";
  // var loginUrl = "https://localhost:5001/api/Users/authenticate";

  final FlutterSecureStorage storage = FlutterSecureStorage();
  final Dio dio = Dio();

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
