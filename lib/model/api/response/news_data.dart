// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// // To parse this JSON data, do
// //
// //     final NewsData = NewsDataFromJson(jsonString);

// import 'dart:convert';

// import 'package:maico_land/model/entities/news.dart';

// NewsData NewsDataFromJson(String str) => NewsData.fromJson(json.decode(str));

// String NewsDataToJson(NewsData data) => json.encode(data.toJson());

// class NewsData {
//   int currentPage;
//   List<News> data;
//   String firstPageUrl;
//   int from;
//   int lastPage;
//   String lastPageUrl;
//   String nextPageUrl;

//   NewsData({
//     this.currentPage,
//     this.data,
//     this.firstPageUrl,
//     this.from,
//     this.lastPage,
//     this.lastPageUrl,
//     this.nextPageUrl,
//   });

//   factory NewsData.fromJson(Map<String, dynamic> json) => NewsData(
//     currentPage: json["current_page"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     firstPageUrl: json["first_page_url"],
//     from: json["from"],
//     lastPage: json["last_page"],
//     lastPageUrl: json["last_page_url"],
//     nextPageUrl: json["next_page_url"],
//   );

//   Map<String, dynamic> toJson() => {
//     "current_page": currentPage,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     "first_page_url": firstPageUrl,
//     "from": from,
//     "last_page": lastPage,
//     "last_page_url": lastPageUrl,
//     "next_page_url": nextPageUrl,
//   };
// }
