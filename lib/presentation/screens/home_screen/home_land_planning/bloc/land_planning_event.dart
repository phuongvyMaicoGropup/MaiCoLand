part of 'land_planning_bloc.dart';

abstract class HomeLandPlanningEvent extends Equatable {
  const HomeLandPlanningEvent();

  @override
  List<Object> get props => [];
}

class InitialHomeLandPlanningEvent extends HomeLandPlanningEvent {}

class LoadHomeLandPlanning extends HomeLandPlanningEvent {}

class RefreshHomeLandPlanning extends HomeLandPlanningEvent {}
