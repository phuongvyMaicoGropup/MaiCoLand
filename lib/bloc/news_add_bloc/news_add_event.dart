part of 'news_add_bloc.dart';

abstract class NewsAddEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsAddButtonPressed extends NewsAddEvent {
  final String title;
  final String content;
  final List<String> hashTags;
  final String imagePath;

  NewsAddButtonPressed(
      {required this.title, required this.content, required this.hashTags, required this.imagePath});
  @override
  List<Object?> get props => [title, content , hashTags, imagePath];

  @override
  String toString() =>
      "NewsAddButtonPressed : ${title}  ";
}
