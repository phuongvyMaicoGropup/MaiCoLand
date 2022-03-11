import 'dart:io';

import 'package:dio/dio.dart';

class UploadFile {
  late bool success;
  late String message;

  late bool isUploaded;
  final dio = Dio(); 

  Future<void> call(String url, File image) async {
    try {
      var response = await dio.post(url, data: image.readAsBytesSync());
      if (response.statusCode == 200) {
        isUploaded = true;
      }
    } catch (e) {
      throw ('Error uploading photo');
    }
  }
}