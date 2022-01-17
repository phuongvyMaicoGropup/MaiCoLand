import 'package:bloc/bloc.dart';
import 'package:land_app/logic/blocs/land_planning/land_planning_event.dart';
import 'package:land_app/logic/blocs/land_planning/land_planning_state.dart';
class LandPlanningBloc

    extends Bloc<LandPlanningEvent, LandPlanningState> {
  
  LandPlanningBloc() : super(LandPlanningLoading())  {

    on<DisplayLandPlanning>(_mapDisplayLandPlanningToState);
  }

  void _mapDisplayLandPlanningToState(DisplayLandPlanning event, emit) async {  
    emit(LandPlanningLoaded(event.landPlannings));
  }

}