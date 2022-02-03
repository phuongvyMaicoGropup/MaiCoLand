import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:land_app/model/entity/news.dart';
import 'package:land_app/model/repository/news_repository.dart';
part 'news_event.dart';
part 'news_state.dart';
class HomeNewsBloc

    extends Bloc<HomeNewsEvent, HomeNewsState> {
  final NewsRepository _newsRepo = NewsRepository();
  
  HomeNewsBloc() : super(NewsLoading())  {
    
    on<HomeDisplayNews>(_mapDisplayNewsToState);
  }

  void _mapDisplayNewsToState(HomeDisplayNews event, emit) async {  
    emit(NewsLoaded(event.news));
  }
  
  @override
  HomeNewsState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(HomeNewsState state) {
    // TODO: implement toJson
    throw UnimplementedError();
  }

}