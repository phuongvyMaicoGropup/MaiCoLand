import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_app/model/entity/app_user.dart';
import 'package:land_app/model/entity/news.dart';
import 'package:land_app/model/repository/news_repository.dart';
import 'package:land_app/model/repository/user_repository.dart';

part 'news_detail_event.dart';
part 'news_detail_state.dart';

class NewsDetailBloc extends Bloc<NewsDetailEvent, NewsDetailState> {
  final NewsRepository _newsRepo = NewsRepository();
  final _userRepo = UserRepository();

  NewsDetailBloc() : super(NewsDetailLoading()) {
    on<NewsDetailOpen>(_mapNewsDetailLoadToState);
    
  }

  void _mapNewsDetailLoadToState(NewsDetailOpen event, emit) async {
    try {
      var user = await _userRepo.getUserByUid(event.news.authorId);
      News news = event.news; 
      news.copyWith(user: user);
      emit(NewsDetailLoaded(news));
    } catch (e) {
      emit(NewsDetailNotLoaded());
    }
  }

}
