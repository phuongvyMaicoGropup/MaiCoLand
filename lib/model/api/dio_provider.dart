import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class DioProvider{
get  baseUrl => "http://maicogroup.net:3005";
  // static String baseUrl = "https://localhost:5001";
  get loginUrl => "http://maicogroup.net:3005/api/Users/authenticate";
  // var loginUrl = "https://localhost:5001/api/Users/authenticate";

  final FlutterSecureStorage storage = FlutterSecureStorage();
  final Dio dio = Dio();

}