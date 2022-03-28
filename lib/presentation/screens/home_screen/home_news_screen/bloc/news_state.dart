part of 'news_bloc.dart';

abstract class HomeNewsState extends Equatable {
  const HomeNewsState();

  @override
  List<Object> get props => [];
}

class HomeNewsLoading extends HomeNewsState {}

class HomeNewsLoaded extends HomeNewsState {
  final List<News> news;

  const HomeNewsLoaded(
    this.news,
  );

  @override
  List<Object> get props => news;

  @override
  String toString() => 'HomeNewsLoaded(news: $news)';

  HomeNewsLoaded copyWith({
    List<News>? news,
  }) {
    return HomeNewsLoaded(
      news ?? this.news,
    );
  }
}

class NewsNotLoaded extends HomeNewsState {}
