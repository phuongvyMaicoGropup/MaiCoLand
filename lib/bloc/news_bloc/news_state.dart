import 'package:equatable/equatable.dart';
import 'package:maico_land/model/entities/news.dart';
// import 'package:maico_land/model/newss/news_news.dart';

class NewsState extends Equatable {
  NewsState(this.news);
  List<News> news;
  @override
  List<Object> get props => [news];
}
  