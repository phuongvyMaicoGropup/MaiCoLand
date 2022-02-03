import 'package:bloc/bloc.dart';
import 'package:land_app/logic/blocs/land_planning/land_planning_event.dart';
import 'package:land_app/logic/blocs/land_planning/land_planning_state.dart';
import 'package:land_app/model/entity/land_planning.dart';
import 'package:land_app/model/repository/planning_land_repository.dart';
class LandPlanningBloc extends Bloc<LandPlanningEvent, LandPlanningState> {
  PlanningLandRepository _LandPlanningsRepository = PlanningLandRepository();
  LandPlanningBloc() : super(LandPlanningLoading())  {

    on<DisplayLandPlanning>(_mapDisplayLandPlanningToState);
  }

  void _mapDisplayLandPlanningToState(DisplayLandPlanning event, emit) async {  
    try {
      
      List<LandPlanning> response =await _LandPlanningsRepository.getAll();
      

      emit(LandPlanningLoaded(response));
    } catch (e) {
      emit(LandPlanningNotLoaded("Lỗi nè " + e.toString()));
    }
    emit(LandPlanningLoaded(event.landPlannings));
  }

}