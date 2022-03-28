import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/model/repositories/Land_repository.dart';
part 'land_planning_event.dart';
part 'land_planning_state.dart';

class HomeLandPlanningBloc
    extends Bloc<HomeLandPlanningEvent, HomeLandPlanningState> {
  final LandPlanningRepository landRepo = LandPlanningRepository();

  HomeLandPlanningBloc() : super(HomeLandPlanningLoading()) {
    on<LoadHomeLandPlanning>(_mapLoadHomeLandPlanningToState);
    on<RefreshHomeLandPlanning>((event, emit) {
      emit(HomeLandPlanningLoading());
    });
  }

  void _mapLoadHomeLandPlanningToState(LoadHomeLandPlanning event, emit) async {
    List<LandPlanning> lands = await landRepo.getHomeLandPlanning();
    emit(HomeLandPlanningLoaded(lands));
  }
}
