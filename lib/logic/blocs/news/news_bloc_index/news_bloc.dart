import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:land_app/model/entity/news.dart';
import 'package:land_app/model/repository/news_repository.dart';
import 'package:rxdart/rxdart.dart';
part 'news_event.dart';
part 'news_state.dart';
class NewsBloc

    extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepo = NewsRepository();
 
  
  Stream<Iterable<News>> get news => _newsRepo.allNewsData;
  NewsBloc() : super(NewsLoading())  {
    
    
     on<NewsLoad>(_mapNewsLoadToState);
    on<NewsRefresh>((event,emit){
        emit(NewsLoading());
    });
  }

  void _mapNewsLoadToState(NewsLoad event, emit) async {  
   try {      
      final response =await _newsRepo.getAll();
 //   final newsRef = _newsRepo.news;
    //   QuerySnapshot<News> querySnapshot = await newsRef.get();
    //   print(querySnapshot);

    // // Get data from docs and convert map to List
    // List<News> allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      emit(NewsLoaded(response));
    } catch (e) {
      emit(NewsNotLoaded());
    }
  }
  



  @override
  NewsState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(NewsState state) {
    // TODO: implement toJson
    throw UnimplementedError();
  }

}