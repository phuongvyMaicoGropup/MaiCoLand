import 'package:equatable/equatable.dart';

class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class InitialNews extends NewsEvent {}

class LoadMoreNews extends NewsEvent {
  final int pageNumber;
  final int pageSize;

  LoadMoreNews(this.pageNumber, this.pageSize); 
}
