import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}
class InitialHomeEvent extends HomeEvent { }
class LoadHome extends HomeEvent {}

class RefreshHome extends HomeEvent {}
