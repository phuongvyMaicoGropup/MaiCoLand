// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:formz/formz.dart';
// import 'package:maico_land/model/api/dio_provider.dart';
// import 'package:maico_land/model/api/request/land_planning_request.dart';
// import 'package:maico_land/model/entities/GeoPoint.dart';
// import 'package:maico_land/model/formz_model/models.dart';
// import 'package:maico_land/model/repositories/land_repository.dart';
// import 'package:maico_land/model/repositories/user_repository.dart';
// import 'package:http/http.dart' as http;
// import 'package:uuid/uuid.dart';
// part 'land_planning_add_event.dart';
// part 'land_planning_add_state.dart';

// class LandPlanningAddBloc
//     extends Bloc<LandPlanningAddEvent, LandPlanningAddState> {
//   final UserRepository _userRepo;
//   final LandPlanningRepository _landPlanningRepo = LandPlanningRepository();
//   final DioProvider _dioProvider = DioProvider();
//   LandPlanningAddBloc({required UserRepository userRepository})
//       : _userRepo = userRepository,
//         super(LandPlanningAddState(
//           leftTop: GeoPoint(0, 0),
//           leftBottom: GeoPoint(0, 0),
//           rightTop: GeoPoint(0, 0),
//           rightBottom: GeoPoint(0, 0),
//           expirationDate: DateTime.now()
//         )) {
//     on<LandPlanningAddTitleChanged>(_onTitleChanged);
//     on<LandPlanningAddContentChanged>(_onContentChanged);
//     on<LandPlanningAddImageChanged>(_onImageChanged);
//     on<LandPlanningAddFilePdfChanged>(_onFilePdfChanged);
//     on<LandPlanningAddExpirationDateChanged>(_onExpirationDateChanged);
//     on<LandPlanningAddLandAreaChanged>(_onLandAreaCHanged);
//     on<LandPlanningAddLeftTopPointChanged>(_onLeftTopPointChanged);
//     on<LandPlanningAddRightTopPointChanged>(_onRightTopPointChanged);
//     on<LandPlanningAddLeftBottomPointChanged>(_onLeftBottomPointChanged);
//     on<LandPlanningAddRightBottomPointChanged>(_onRightBottomPointChanged);

//     on<LandPlanningAddSubmitted>(_onSubmitted);
//   }
//   void _onTitleChanged(
//     LandPlanningAddTitleChanged event,
//     Emitter<LandPlanningAddState> emit,
//   ) {
//     final title = Title.dirty(event.title.toString());
//     emit(state.copyWith(
//       title: title,
//       status: Formz.validate([state.content, title]),
//     ));
//   }

//   void _onContentChanged(
//     LandPlanningAddContentChanged event,
//     Emitter<LandPlanningAddState> emit,
//   ) {
//     final content = Content.dirty(event.content.toString());
//     emit(state.copyWith(
//       content: content,
//       status: Formz.validate([content, state.title]),
//     ));
//   }

//   void _onImageChanged(
//     LandPlanningAddImageChanged event,
//     Emitter<LandPlanningAddState> emit,
//   ) {
//     print(event.image);
//     emit(state.copyWith(
//       imageUrl: event.image,
//       status: Formz.validate([state.content, state.title]),
//     ));
//   }

//   void _onFilePdfChanged(
//     LandPlanningAddFilePdfChanged event,
//     Emitter<LandPlanningAddState> emit,
//   ) {
//     emit(state.copyWith(
//       filePdfUrl: state.filePdfUrl,
//     ));
//   }

//   void _onExpirationDateChanged(
//     LandPlanningAddExpirationDateChanged event,
//     Emitter<LandPlanningAddState> emit,
//   ) {
//     emit(state.copyWith(
//       expirationDate: state.expirationDate,
//     ));
//   }

//   void _onLandAreaCHanged(
//     LandPlanningAddLandAreaChanged event,
//     Emitter<LandPlanningAddState> emit,
//   ) {
//     emit(state.copyWith(
//       landArea: state.landArea,
//     ));
//   }

//   void _onLeftTopPointChanged(
//     LandPlanningAddLeftTopPointChanged event,
//     Emitter<LandPlanningAddState> emit,
//   ) {
//     emit(state.copyWith(
//       leftTop: state.leftTop,
//     ));
//   }

//   void _onLeftBottomPointChanged(
//     LandPlanningAddLeftBottomPointChanged event,
//     Emitter<LandPlanningAddState> emit,
//   ) {
//     emit(state.copyWith(
//       leftBottom: state.leftBottom,
//     ));
//   }

//   void _onRightBottomPointChanged(
//     LandPlanningAddRightBottomPointChanged event,
//     Emitter<LandPlanningAddState> emit,
//   ) {
//     emit(state.copyWith(
//       rightBottom: state.rightBottom,
//     ));
//   }

//   void _onRightTopPointChanged(
//     LandPlanningAddRightTopPointChanged event,
//     Emitter<LandPlanningAddState> emit,
//   ) {
//     emit(state.copyWith(
//       rightTop: state.rightTop,
//     ));
//   }

//   void _onSubmitted(
//     LandPlanningAddSubmitted event,
//     Emitter<LandPlanningAddState> emit,
//   ) async {
//     if (state.status.isValidated) {
//       try {
//         String fileId = Uuid().v4();
//         var imagePath = await _dioProvider.uploadFile(
//           state.imageUrl,
//           "image/png",
//           "land-planning/" + fileId,
//         );
//         var filePdfPath = await _dioProvider.uploadFile(
//           state.filePdfUrl,
//           "application/pdf",
//           "land-planning/" + fileId,
//         );

//         var request = LandPlanningRequest(
//           state.title.value,
//           state.content.value,
//           state.imageUrl,
//           state.landArea,
//           state.filePdfUrl,
//           state.expirationDate,
//           state.leftTop,
//           state.rightTop,
//           state.leftBottom,
//           state.rightBottom,
//         );

//         // var result = await _landPlanningRepo.create(LandPlanningRequest);
//         var result = true;
//         if (result == true) {
//           emit(state.copyWith(status: FormzStatus.submissionSuccess));
//         } else {
//           emit(state.copyWith(status: FormzStatus.submissionFailure));
//         }
//       } catch (e) {
//         emit(state.copyWith(status: FormzStatus.submissionFailure));
//       }
//       emit(state.copyWith(status: FormzStatus.submissionInProgress));
//     }
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maico_land/model/api/dio_provider.dart';
import 'package:maico_land/model/api/request/land_planning_request.dart';
import 'package:maico_land/model/repositories/land_repository.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:uuid/uuid.dart';
part 'land_planning_add_event.dart';
part 'land_planning_add_state.dart';

class LandPlanningAddBloc
    extends Bloc<LandPlanningAddEvent, LandPlanningAddState> {
  final UserRepository _userRepo;
  final LandPlanningRepository _landPlanningRepo = LandPlanningRepository();
  final DioProvider _dioProvider = DioProvider();
  LandPlanningAddBloc({required UserRepository userRepository})
      : _userRepo = userRepository,
        super(LandPlanningInitial()) {
    on<LandPlanningAddSubmitted>(_onSubmitted);
  }
  void _onSubmitted(
    LandPlanningAddSubmitted event,
    Emitter<LandPlanningAddState> emit,
  ) async {
    try {
      String fileId = const Uuid().v4();
      var imagePath = await _dioProvider.uploadFile(
        event.land.imageUrl,
        "image/png",
        "land-planning/" + fileId,
      );
      var filePdfPath = await _dioProvider.uploadFile(
        event.land.filePdfUrl,
        "application/pdf",
        "land-planning/" + fileId,
      );

      var result = await _landPlanningRepo.create(event.land);
      if (result == true) {
        emit(LandPlanningSuccess());
      } else {
        emit(LandPlanningFailure());
      }
    } catch (e) {
      emit(LandPlanningFailure());
    }
    emit(LandPlanningLoading());
  }
}
