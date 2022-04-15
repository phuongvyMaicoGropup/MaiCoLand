part of 'top_news_bloc.dart';

abstract class TopNewsEvent extends Equatable {
  const TopNewsEvent();

  @override
  List<Object> get props => [];
}

class InitialTopNewsEvent extends TopNewsEvent {}

class LoadTopNews extends TopNewsEvent {}

class RefreshTopNews extends TopNewsEvent {}
