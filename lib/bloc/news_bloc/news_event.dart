import 'package:equatable/equatable.dart';
import 'package:maico_land/model/entities/news.dart';

class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class InitialNews extends NewsEvent {}

class LoadMoreNews extends NewsEvent {
  final List<News> news; 

  const LoadMoreNews(this.news);
}
