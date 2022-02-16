
part of 'news_detail_bloc.dart';

abstract class NewsDetailEvent extends Equatable{
   @override
  List<Object> get props => [];

}


class NewsDetailOpen extends NewsDetailEvent {
   final News news;

  NewsDetailOpen({required this.news});

}
