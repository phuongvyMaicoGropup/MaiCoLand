part of 'land_planning_bloc.dart';

abstract class HomeLandPlanningState extends Equatable {
  const HomeLandPlanningState();

  @override
  List<Object> get props => [];
}

class HomeLandPlanningLoading extends HomeLandPlanningState {}

class HomeLandPlanningLoaded extends HomeLandPlanningState {
  final List<LandPlanning> land;

  const HomeLandPlanningLoaded(
    this.land,
  );

  @override
  List<Object> get props => [land];

  @override
  String toString() => 'LandPlanningLoaded(LandPlanning: $LandPlanning)';

  HomeLandPlanningLoaded copyWith({
    List<LandPlanning>? land,
  }) {
    return HomeLandPlanningLoaded(
      land ?? this.land,
    );
  }
}

class LandPlanningNotLoaded extends HomeLandPlanningState {}
