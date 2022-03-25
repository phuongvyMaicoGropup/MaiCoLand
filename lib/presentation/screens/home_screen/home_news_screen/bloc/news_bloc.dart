import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
part 'news_event.dart';
part 'news_state.dart';

class HomeNewsBloc extends Bloc<HomeNewsEvent, HomeNewsState> {
  final NewsRepository newsRepo = NewsRepository();

  HomeNewsBloc() : super(NewsLoading()) {
    on<HomeDisplayNews>(_mapDisplayNewsToState);
  }

  void _mapDisplayNewsToState(HomeDisplayNews event, emit) async {
    List<News> newsList = await newsRepo.getHomeNews();
    emit(NewsLoaded(newsList));
  }
}
