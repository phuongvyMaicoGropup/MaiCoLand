import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:maico_land/model/api/dio_provider.dart';
import 'package:maico_land/model/api/request/news_request.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/formz_model/models.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:http/http.dart' as http;
part 'news_add_event.dart';
part 'news_add_state.dart';

class NewsAddBloc extends Bloc<NewsAddEvent, NewsAddState> {
  final UserRepository _userRepo;
  final NewsRepository _newsRepo = NewsRepository();
  final DioProvider _dioProvider = DioProvider();
  NewsAddBloc({required UserRepository userRepository})
      : _userRepo = userRepository,
        super(const NewsAddState()) {
    on<NewsAddTitleChanged>(_onTitleChanged);
    on<NewsAddContentChanged>(_onContentChanged);
    on<NewsAddImageChanged>(_onImageChanged);
    on<NewsAddHashTagChanged>(_onHashTagChanged);
    on<NewsAddSubmitted>(_onSubmitted);
  }
  void _onTitleChanged(
    NewsAddTitleChanged event,
    Emitter<NewsAddState> emit,
  ) {
    final title = Title.dirty(event.title.toString());
    emit(state.copyWith(
      title: title,
      status: Formz.validate([state.content, title]),
    ));
  }

  void _onContentChanged(
    NewsAddContentChanged event,
    Emitter<NewsAddState> emit,
  ) {
    final content = Content.dirty(event.content.toString());
    emit(state.copyWith(
      content: content,
      status: Formz.validate([content, state.title]),
    ));
  }

  void _onImageChanged(
    NewsAddImageChanged event,
    Emitter<NewsAddState> emit,
  ) {
    print("tesst image");
    print(event.image);
    emit(state.copyWith(
      image: event.image,
      status: Formz.validate([state.content, state.title]),
    ));
  }

  void _onHashTagChanged(
    NewsAddHashTagChanged event,
    Emitter<NewsAddState> emit,
  ) {
    print("hashTag changed event");
    print(event.hashTag);
    emit(state.copyWith(
      hashTag: event.hashTag,
      status: Formz.validate([state.content, state.title]),
    ));
  }

  void _onSubmitted(
    NewsAddSubmitted event,
    Emitter<NewsAddState> emit,
  ) async {
    if (state.status.isValidated) {
      try {
        var imagePath =
            await _dioProvider.uploadFile(state.image, "image/png", "news");

        var newsRequest = NewsRequest(state.title.value, state.content.value,
            state.hashTag.split('/').toList(), imagePath);

        var result = await _newsRepo.create(newsRequest);
        if (result == true) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      } catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
    }
  }
}
