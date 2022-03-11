
// import 'dart:convert';

// import 'package:maico_land/model/api/dio_provider.dart';


// class GenerateImageUrl {
//   late bool success;
//   late String message;

//   late bool isGenerated;
//   late String uploadUrl;
//   late String downloadUrl;
//   var dio_provider = DioProvider(); 

//   Future<void> call(String fileType) async {
//     try {
//       Map body = {"fileType": fileType};

//       var response = await dio_provider.dio.post(
//         "https://hn.ss.bfcplatform.vn/maicoland/news/d60e52e0-139a-4c3e-9bc0-fd768f4ef3d7?AWSAccessKeyId=8EL21GNHMRNZYW8488OV&Expires=1646820070&Signature=iIpJubOXjjr5toqGg6aF50w%2B%2F2s%3D",
//         data: body,
//       );

//       var result = jsonDecode(response.body);

//       print(result);

//       if (result['success'] != null) {
//         success = result['success'];
//         message = result['message'];

//         if (response.statusCode == 201) {
//           isGenerated = true;
//           uploadUrl = result["uploadUrl"];
//           downloadUrl = result["downloadUrl"];
//         }
//       }
//     } catch (e) {
//       throw ('Error getting url');
//     }
//   }
// }