part of 'news_add_bloc.dart'; 


abstract class NewsAddState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NewsAddInitial extends NewsAddState {}

class NewsAddLoading extends NewsAddState {}

class NewsAddFailure extends NewsAddState {
  final String error;

  NewsAddFailure({required this.error});
  @override
  List<Object?> get props => [error];

  @override
  String toString() => "Error : ${error}";  
}
