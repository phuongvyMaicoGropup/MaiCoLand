import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/sale_post_bloc/sale_post_event.dart';
import 'package:maico_land/bloc/sale_post_bloc/sale_post_state.dart';
import 'package:maico_land/model/api/dio_provider.dart';
import 'package:maico_land/model/formz_model/path_image.dart';
import 'package:maico_land/model/repositories/news_repository.dart';

import '../../model/repositories/user_repository.dart';

class SalePostBloc extends Bloc<SalePostEvent, SalePostState> {
  final UserRepository _userRepo;
  final NewsRepository _newsRepo = NewsRepository();
  final DioProvider _dioProvider = DioProvider();
  SalePostBloc({required UserRepository userRepository})
      : _userRepo = userRepository,
        super(const SalePostState()) {
    on<SalePostAddInitial>(_onInitial);
    on<SalePostImageChanged>(_salePostChange);
  }
  void _onInitial(
    SalePostEvent event,
    Emitter<SalePostState> emit,
  ) {
    emit(state.copyWith(
      images: const PathImage.pure(),
    ));
  }

  void _salePostChange(
      SalePostImageChanged event, Emitter<SalePostState> emit) {
    emit(state.copyWith(
      images: PathImage.dirty(event.images),
    ));

    ///Khá vô lí nhưng không lặp lại như này lại không update bên UI :V . Ui la
    emit(state.copyWith(
      images: PathImage.dirty(event.images),
    ));
  }
}
