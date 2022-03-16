// import 'package:bloc/bloc.dart';
// import 'package:maico_land/model/repositories/news_repository.dart';
// import 'package:meta/meta.dart';

// import 'news_event.dart';
// import 'news_state.dart';

// class NewsBloc extends Bloc<NewsEvent, NewsState> {
//   final NewsRepository newsRepo ;
//   NewsBloc({required this.newsRepo})
//       : super(NewsLoading()) {
//     on<LoadNews>(_mapLoadNewsToState);
//     on<RefreshNews>((event, emit) {
//       emit(NewsLoading());
//     });
//   }

//   void _mapLoadNewsToState(
//     LoadNews event,
//     Emitter<NewsState> emit,`  ` 
//   ) async {
//     try {
//       // await _newsRepo.

//       emit(NewsLoaded(response: response));
//     } catch (e) {
//       emit(NewsNotLoaded("Lỗi nè " + e.toString()));
//     }
//   }
// }
