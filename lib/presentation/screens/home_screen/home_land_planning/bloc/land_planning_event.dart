
part of 'land_planning_bloc.dart';
abstract class HomeLandPlanningEvent extends Equatable {
  const HomeLandPlanningEvent();

  @override
  List<Object> get props => [];
}


class HomeDisplayLandPlanning extends HomeLandPlanningEvent {
  final List<LandPlanning> land;

  const HomeDisplayLandPlanning(this.land);

  @override
  List<Object> get props => [land];

  @override
  String toString() {
    return 'Dispaly LandPlanning : {LandPlanning: $land}';
  }
}
