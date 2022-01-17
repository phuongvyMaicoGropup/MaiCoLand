import 'package:equatable/equatable.dart';
import 'package:land_app/model/entity/land_planning.dart';

abstract class LandPlanningEvent extends Equatable {
  const LandPlanningEvent();

  @override
  List<Object> get props => [];
}

class DisplayLandPlanning extends LandPlanningEvent {
  final List<LandPlanning> landPlannings;

  const DisplayLandPlanning(this.landPlannings);

  @override
  List<Object> get props => [landPlannings];

  @override
  String toString() {
    return 'Dispaly landPlanning : {landPlannings: $landPlannings}';
  }
}