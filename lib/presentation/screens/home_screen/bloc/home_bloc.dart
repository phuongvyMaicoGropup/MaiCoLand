import 'package:bloc/bloc.dart';
import 'package:maico_land/model/repositories/home_repository.dart';
import 'package:maico_land/model/responses/home_response.dart';
import 'package:maico_land/presentation/screens/home_screen/home_land_planning/bloc/land_planning_bloc.dart';
import 'package:maico_land/presentation/screens/home_screen/home_news_screen/bloc/news_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  final HomeNewsBloc newsBloc;
  final HomeLandPlanningBloc landBloc;

  HomeBloc(
      {required this.homeRepository,
      required this.newsBloc,
      required this.landBloc})
      : super(HomeLoading()) {
    on<LoadHome>(_mapLoadHomeToState);
    on<RefreshHome>((event, emit) {
      emit(HomeLoading());
    });
  }

  void _mapLoadHomeToState(
    LoadHome event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await homeRepository.getHomeData();
      HomeResponse response = HomeResponse(
          news: homeRepository.news,
          landPlannings: homeRepository.landPlannings);
      // newsBloc.add(HomeDisplayNews(homeRepository.news));
      // landBloc.add(HomeDisplayLandPlanning(homeRepository.landPlannings));
      emit(HomeLoaded(response: response));
    } catch (e) {
      emit(HomeNotLoaded("Lỗi nè " + e.toString()));
    }
  }
}
