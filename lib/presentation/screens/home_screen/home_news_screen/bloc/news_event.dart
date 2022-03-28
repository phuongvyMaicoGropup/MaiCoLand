part of 'news_bloc.dart';

abstract class HomeNewsEvent extends Equatable {
  const HomeNewsEvent();

  @override
  List<Object> get props => [];
}

class InitialHomeNewsEvent extends HomeNewsEvent {}

class LoadHomeNews extends HomeNewsEvent {}

class RefreshHomeNews extends HomeNewsEvent {}
