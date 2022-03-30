import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:maico_land/model/api/dio_provider.dart';
import 'package:maico_land/model/api/request/news_request.dart';
import 'package:maico_land/model/formz_model/models.dart';
import 'package:maico_land/model/formz_model/path_image.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
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
    on<NewsAddInitial>(_onInitial);
  }
  void _onInitial(
    NewsAddInitial event,
    Emitter<NewsAddState> emit,
  ) {
    emit(state.copyWith(
      title: const Title.pure(),
      content: const Content.pure(),
      image: const PathImage.pure(),
      hashTag: "",
      status: FormzStatus.pure,
    ));
  }

  void _onTitleChanged(
    NewsAddTitleChanged event,
    Emitter<NewsAddState> emit,
  ) {
    final title = Title.dirty(event.title.toString());
    emit(state.copyWith(
      title: title,
      status: Formz.validate([state.content, title, state.image]),
    ));
    Future.delayed(const Duration(milliseconds: 500));
  }

  void _onContentChanged(
    NewsAddContentChanged event,
    Emitter<NewsAddState> emit,
  ) {
    final content = Content.dirty(event.content.toString());
    emit(state.copyWith(
      content: content,
      status: Formz.validate([content, state.title, state.image]),
    ));
    print("_onContentChanged" +
        Formz.validate([state.content, state.title, state.image]).toString());
  }

  void _onImageChanged(
    NewsAddImageChanged event,
    Emitter<NewsAddState> emit,
  ) {
    emit(state.copyWith(
      image: PathImage.dirty(event.image),
      status: Formz.validate([state.content, state.title, state.image]),
    ));

    ///Khá vô lí nhưng không lặp lại như này lại không update bên UI
    emit(state.copyWith(
      image: PathImage.dirty(event.image),
      status: Formz.validate([state.content, state.title, state.image]),
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
      status: Formz.validate([state.content, state.title, state.image]),
    ));
  }

  void _onSubmitted(
    NewsAddSubmitted event,
    Emitter<NewsAddState> emit,
  ) async {
    if (state.status.isValid) {
      try {
        var imagePath = await _dioProvider.uploadFile(
            state.image.value, "image/png", "news");
        print(event.type);

        var newsRequest = NewsRequest(state.title.value, state.content.value,
            state.hashTag.split('/').toList(), imagePath, event.type);

        var result = await _newsRepo.create(newsRequest);
        if (result == true) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }

        state.copyWith(image: const PathImage.pure());
      } catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
        state.copyWith(image: const PathImage.pure());
      }
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
    }
  }
}
