import 'package:bloc/bloc.dart';
import 'package:maico_land/model/repositories/home_repository.dart';
import 'package:maico_land/model/responses/home_response.dart';
import 'package:meta/meta.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(HomeLoading()){
    on<LoadHome>(_mapLoadHomeToState);
    on<RefreshHome>((event,emit){
        emit(HomeLoading());
    });
  }


  void _mapLoadHomeToState(LoadHome event, Emitter<HomeState> emit,) async {
    try {

      // await homeRepository.getHomeData();
      HomeResponse response =HomeResponse();

      emit(HomeLoaded(response: response));
    } catch (e) {
      emit(HomeNotLoaded("Lỗi nè " + e.toString()));
    }
  }
  
}
