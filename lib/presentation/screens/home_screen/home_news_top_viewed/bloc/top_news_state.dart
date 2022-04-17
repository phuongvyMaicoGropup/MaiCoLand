part of 'top_news_bloc.dart';

abstract class TopNewsState extends Equatable {
  const TopNewsState();

  @override
  List<Object> get props => [];
}

class TopNewsLoading extends TopNewsState {}

class TopNewsLoaded extends TopNewsState {
  final List<String> news;

  const TopNewsLoaded(
    this.news,
  );

  @override
  List<Object> get props => news;

  @override
  String toString() => 'TopNewsLoaded(news: $news)';

  TopNewsLoaded copyWith({
    List<String>? news,
  }) {
    return TopNewsLoaded(
      news ?? this.news,
    );
  }
}

class TopNewsNotLoaded extends TopNewsState {}
