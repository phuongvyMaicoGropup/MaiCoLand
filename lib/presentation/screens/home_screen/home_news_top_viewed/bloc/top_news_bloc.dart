import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
part 'top_news_event.dart';
part 'top_news_state.dart';

class TopNewsBloc extends Bloc<TopNewsEvent, TopNewsState> {
  late NewsRepository newsRepo;

  TopNewsBloc({required this.newsRepo}) : super(TopNewsLoading()) {
    on<LoadTopNews>(_mapLoadTopNewsToState);
    on<RefreshTopNews>((event, emit) {
      emit(TopNewsLoading());
    });
  }

  void _mapLoadTopNewsToState(LoadTopNews event, emit) async {
    try {
      List<String> newsList = await newsRepo.getTopViewed();
      emit(TopNewsLoaded(newsList));
    } catch (e) {
      emit(TopNewsNotLoaded());
    }
  }
}
