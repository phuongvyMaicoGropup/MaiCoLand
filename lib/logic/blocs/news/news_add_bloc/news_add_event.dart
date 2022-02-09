part of 'news_add_bloc.dart';


abstract class NewsAddEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class NewsAddTitleChanged extends NewsAddEvent{
  final String title;
  NewsAddTitleChanged(this.title);
  @override
  List<Object> get props =>[title];
}

class NewsAddContentChanged extends NewsAddEvent{
  final String content;
  NewsAddContentChanged(this.content);
  @override
  List<Object> get props =>[content];
}
class NewsAddHashTagChanged extends NewsAddEvent{
  final String hashTag ;
  NewsAddHashTagChanged(this.hashTag);
  @override
  List<Object> get props =>[hashTag];
}
class NewsAddImageChanged extends NewsAddEvent{
  final String image ;
  NewsAddImageChanged(this.image);
  @override
  List<Object> get props =>[image];
}
class NewsAddSubmitted extends NewsAddEvent{
   NewsAddSubmitted();
}

