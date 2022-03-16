import 'package:equatable/equatable.dart';
import 'package:maico_land/model/entities/news.dart';
// import 'package:maico_land/model/newss/news_news.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<News> news;

  const NewsLoaded( {required this.news});

  @override
  List<Object> get props {
    return [news];
  }

  @override
  String toString() {
    return 'NewsLoaded{news: $news}';
  }
}

class NewsNotLoaded extends NewsState {
  final String e;

  const NewsNotLoaded(this.e);

  @override
  String toString() {
    return 'NewsNotLoaded{e: $e}';
  }
}
