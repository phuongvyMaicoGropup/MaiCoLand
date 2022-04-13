import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
part 'news_event.dart';
part 'news_state.dart';

class HomeNewsBloc extends Bloc<HomeNewsEvent, HomeNewsState> {
  final NewsRepository newsRepo = NewsRepository();

  HomeNewsBloc() : super(HomeNewsLoading()) {
    on<LoadHomeNews>(_mapLoadHomeNewsToState);
    on<RefreshHomeNews>((event, emit) {
      emit(HomeNewsLoading());
    });
  }

  void _mapLoadHomeNewsToState(LoadHomeNews event, emit) async {
    List<String> newsList = await newsRepo.getHomeNews();
    emit(HomeNewsLoaded(newsList));
  }
}
