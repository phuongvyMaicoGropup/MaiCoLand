import 'package:equatable/equatable.dart';

class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}
class InitialNewsEvent extends NewsEvent { }
class LoadNews extends NewsEvent {}

class RefreshNews extends NewsEvent {}
