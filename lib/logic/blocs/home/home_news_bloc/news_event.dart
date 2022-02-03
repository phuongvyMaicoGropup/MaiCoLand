
part of 'news_bloc.dart';
abstract class HomeNewsEvent extends Equatable {
  const HomeNewsEvent();

  @override
  List<Object> get props => [];
}


class HomeDisplayNews extends HomeNewsEvent {
  final List<News> news;

  const HomeDisplayNews(this.news);

  @override
  List<Object> get props => [news];

  @override
  String toString() {
    return 'Dispaly news : {news: $news}';
  }
}
