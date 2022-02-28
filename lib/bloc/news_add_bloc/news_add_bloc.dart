

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/user_repository.dart';

part 'news_add_event.dart';
part 'news_add_state.dart';

class NewsAddBloc extends Bloc<NewsAddEvent,NewsAddState>{
  final UserRepository userRepo; 
  NewsAddBloc({required  this.userRepo}) :
  super(NewsAddInitial()){
    on<NewsAddButtonPressed>(_onSubmitted);
    
  }
  
  void _onSubmitted(
      NewsAddButtonPressed event,
      Emitter<NewsAddState> emit,
      ) async {
    
    emit(NewsAddLoading());

    try {
      
      
      emit(NewsAddInitial());
    } catch (e) {
      emit(NewsAddFailure(error: e.toString()));
    }
  }
}