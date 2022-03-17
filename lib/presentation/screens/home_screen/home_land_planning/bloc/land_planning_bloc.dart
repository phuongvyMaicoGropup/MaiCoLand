import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/model/repositories/Land_repository.dart';
part 'land_planning_event.dart';
part 'land_planning_state.dart';

class HomeLandPlanningBloc extends Bloc<HomeLandPlanningEvent, HomeLandPlanningState> {
  final LandPlanningRepository landRepo = LandPlanningRepository();

  HomeLandPlanningBloc() : super(LandPlanningLoading()) {
    on<HomeDisplayLandPlanning>(_mapDisplayLandPlanningToState);
  }

  void _mapDisplayLandPlanningToState(HomeDisplayLandPlanning event, emit) async {
    emit(LandPlanningLoaded(event.land));
  }
}
