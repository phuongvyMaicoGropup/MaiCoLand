// import 'dart:async';

// import 'package:rxdart/rxdart.dart';

// class ActionBloc{ 
//   final _isWatchNewsController = StreamController<String>();
//   final _isLoadingSubject = BehaviorSubject<bool>();
//   Sink<String> get isWatchNews => _isWatchNewsController.sink;
//   _update(List<int> ids) async {
//     _isLoadingSubject.add(true);
//     await _updateArticles(ids);
//     _articleSubject.add((_articles));
//     _isLoadingSubject.add(false);
//   }a

// }