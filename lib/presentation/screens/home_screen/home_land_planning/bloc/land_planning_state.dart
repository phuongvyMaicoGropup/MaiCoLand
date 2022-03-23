part of 'land_planning_bloc.dart';

abstract class HomeLandPlanningState extends Equatable {
  const HomeLandPlanningState();

  @override
  List<Object> get props => [];
}

class LandPlanningLoading extends HomeLandPlanningState {}

class LandPlanningLoaded extends HomeLandPlanningState {
  final List<LandPlanning> land;

  const LandPlanningLoaded(
    this.land,
  );

  @override
  List<Object> get props => [land];

  @override
  String toString() => 'LandPlanningLoaded(LandPlanning: $LandPlanning)';

  LandPlanningLoaded copyWith({
    List<LandPlanning>? land,
  }) {
    return LandPlanningLoaded(
      land ?? this.land,
    );
  }
}

class LandPlanningNotLoaded extends HomeLandPlanningState {}
