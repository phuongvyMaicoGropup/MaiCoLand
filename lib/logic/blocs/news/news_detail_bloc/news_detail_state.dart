

part of 'news_detail_bloc.dart';

abstract class NewsDetailState extends Equatable {
  const NewsDetailState();

  @override
  List<Object> get props => [];
}
class NewsDetailLoading extends NewsDetailState {}

class NewsDetailLoaded extends NewsDetailState {
  final News news;

  NewsDetailLoaded(
    this.news,
  );

  @override
  List<Object> get props => [news];

  @override
  String toString() => 'NewsDetailLoaded(news: $news)';

  NewsDetailLoaded copyWith({
    News? news,
  }) {
    return NewsDetailLoaded(
      news ?? this.news,
    );
  }

}

class NewsDetailNotLoaded extends NewsDetailState {}