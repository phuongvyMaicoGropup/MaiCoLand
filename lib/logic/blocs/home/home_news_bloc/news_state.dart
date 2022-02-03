

part of 'news_bloc.dart';

abstract class HomeNewsState extends Equatable {
  const HomeNewsState();

  @override
  List<Object> get props => [];
}
class NewsLoading extends HomeNewsState {}

class NewsLoaded extends HomeNewsState {
  final List<News> news;

  NewsLoaded(
    this.news,
  );

  @override
  List<Object> get props => news;

  @override
  String toString() => 'NewsLoaded(news: $news)';

  NewsLoaded copyWith({
    List<News>? news,
  }) {
    return NewsLoaded(
      news ?? this.news,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'news': news.map((x) => x.toMap()).toList(),
  //   };
  // }

  // factory NewsLoaded.fromMap(Map<String, dynamic> map) {
  //   return NewsLoaded(
  //     List<News>.from(map['news']?.map((x) => News.fromMap(x))),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory NewsLoaded.fromJson(String source) => NewsLoaded.fromMap(json.decode(source));

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;
  
  //   return other is NewsLoaded &&
  //     listEquals(other.news, news);
  // }

  // @override
  // int get hashCode => news.hashCode;
}

class NewsNotLoaded extends HomeNewsState {}