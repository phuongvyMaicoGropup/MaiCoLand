part of 'news_add_bloc.dart';

abstract class NewsAddEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NewsAddTitleChanged extends NewsAddEvent {
  final String title;
  NewsAddTitleChanged(this.title);
  @override
  List<Object> get props => [title];
}

class NewsAddContentChanged extends NewsAddEvent {
  final String content;
  NewsAddContentChanged(this.content);
  @override
  List<Object> get props => [content];
}

class NewsAddHashTagChanged extends NewsAddEvent {
  final String hashTag;
  NewsAddHashTagChanged(this.hashTag);
  @override
  List<Object> get props => [hashTag];
}

class NewsAddImageChanged extends NewsAddEvent {
  final List<String> images;
  NewsAddImageChanged(this.images);
  @override
  List<Object> get props => [images];
}

class NewsAddSubmitted extends NewsAddEvent {
  final int type;
  NewsAddSubmitted(this.type);
}

class NewsAddInitial extends NewsAddEvent {}
