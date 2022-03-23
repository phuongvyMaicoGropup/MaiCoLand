import 'package:bloc/bloc.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/news_repository.dart';

import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepo;
  NewsBloc({required this.newsRepo}) : super(NewsState(const [])) {
    on<InitialNews>(_mapInitialNewsToState);
    on<LoadMoreNews>(_mapLoadMoreNewsToState);
  }
  void _mapInitialNewsToState(
      InitialNews event, Emitter<NewsState> emit) async {
    List<News> news = await newsRepo.getNewsPagination(1, 10);
    state.news = news;
  }

  void _mapLoadMoreNewsToState(
      LoadMoreNews event, Emitter<NewsState> emit) async {
    state.news.addAll(event.news);
  }
}
