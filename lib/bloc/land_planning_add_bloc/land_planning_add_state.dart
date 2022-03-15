part of 'land_planning_add_bloc.dart';

// class LandPlanningAddState extends Equatable {
//   const LandPlanningAddState({
//     this.title = const Title.pure(),
//     this.content = const Content.pure(),
//     this.imageUrl = "maico-logo.png",
//     this.filePdfUrl = "",
//     this.landArea = 0,
//     required this.leftTop,
//     required this.rightTop,
//     required this.leftBottom,
//     required this.rightBottom,
//     required this.expirationDate,
//     this.status = FormzStatus.pure,
//   });

//   final Title title;
//   final Content content;
//   final String imageUrl;
//   final String filePdfUrl;
//   final double landArea;
//   final GeoPoint leftTop;
//   final GeoPoint rightTop;
//   final GeoPoint leftBottom;
//   final GeoPoint rightBottom;
//   final DateTime expirationDate;
//   // final File? pdfContent ;
//   final FormzStatus status;

//   @override
//   List<Object> get props {
//     return [
//       title,
//       content,
//       imageUrl,
//       filePdfUrl,
//       landArea,
//       leftTop,
//       rightTop,
//       leftBottom,
//       rightBottom,
//       expirationDate,
//       status,
//     ];
//   }

//   LandPlanningAddState copyWith({
//     Title? title,
//     Content? content,
//     String? imageUrl,
//     String? filePdfUrl,
//     double? landArea,
//     GeoPoint? leftTop,
//     GeoPoint? rightTop,
//     GeoPoint? leftBottom,
//     GeoPoint? rightBottom,
//     DateTime? expirationDate,
//     FormzStatus? status,
//   }) {
//     return LandPlanningAddState(
//       title: title ?? this.title,
//       content: content ?? this.content,
//       imageUrl: imageUrl ?? this.imageUrl,
//       filePdfUrl: filePdfUrl ?? this.filePdfUrl,
//       landArea: landArea ?? this.landArea,
//       leftTop: leftTop ?? this.leftTop,
//       rightTop: rightTop ?? this.rightTop,
//       leftBottom: leftBottom ?? this.leftBottom,
//       rightBottom: rightBottom ?? this.rightBottom,
//       expirationDate: expirationDate ?? this.expirationDate,
//       status: status ?? this.status,
//     );
//   }

//   @override
//   String toString() {
//     return 'LandPlanningAddState(title: $title, content: $content, imageUrl: $imageUrl, filePdfUrl: $filePdfUrl, landArea: $landArea, leftTop: $leftTop, rightTop: $rightTop, leftBottom: $leftBottom, rightBottom: $rightBottom, expirationDate: $expirationDate, status: $status)';
//   }
// }
class LandPlanningAddState extends Equatable {
  // final LandPlanningRequest land;

  // LandPlanningAddState(this.land);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LandPlanningInitial extends LandPlanningAddState{
  
}

class LandPlanningLoading extends LandPlanningAddState{}
class LandPlanningSuccess extends LandPlanningAddState{
  
}

class LandPlanningFailure extends LandPlanningAddState{

}