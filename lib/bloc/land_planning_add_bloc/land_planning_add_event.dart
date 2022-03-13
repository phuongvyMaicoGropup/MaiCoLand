part of 'land_planning_add_bloc.dart';

abstract class LandPlanningAddEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class LandPlanningAddTitleChanged extends LandPlanningAddEvent{
  final String title;
  LandPlanningAddTitleChanged(this.title);
  @override
  List<Object> get props =>[title];
}

class LandPlanningAddContentChanged extends LandPlanningAddEvent{
  final String content;
  LandPlanningAddContentChanged(this.content);
  @override
  List<Object> get props =>[content];
}
class LandPlanningAddFilePdfChanged extends LandPlanningAddEvent{
  final String filePdf ;
  LandPlanningAddFilePdfChanged(this.filePdf);
  @override
  List<Object> get props =>[filePdf];
}
class LandPlanningAddImageChanged extends LandPlanningAddEvent{
  final String image ;
  LandPlanningAddImageChanged(this.image);
  @override
  List<Object> get props =>[image];
}

class LandPlanningAddLandAreaChanged extends LandPlanningAddEvent{
  final double value ;
  LandPlanningAddLandAreaChanged(this.value);
  @override
  List<Object> get props =>[value];
}

class LandPlanningAddExpirationDateChanged extends LandPlanningAddEvent{
  final DateTime date ;
  LandPlanningAddExpirationDateChanged(this.date);
  @override
  List<Object> get props =>[date];
}
class LandPlanningAddLeftTopPointChanged extends LandPlanningAddEvent{
  final GeoPoint point ;
  LandPlanningAddLeftTopPointChanged(this.point);
  @override
  List<Object> get props =>[point];
}

class LandPlanningAddRightTopPointChanged extends LandPlanningAddEvent{
  final GeoPoint point ;
  LandPlanningAddRightTopPointChanged(this.point);
  @override
  List<Object> get props =>[point];
}
class LandPlanningAddLeftBottomPointChanged extends LandPlanningAddEvent{
  final GeoPoint point ;
  LandPlanningAddLeftBottomPointChanged(this.point);
  @override
  List<Object> get props =>[point];
}
class LandPlanningAddRightBottomPointChanged extends LandPlanningAddEvent{
  final GeoPoint point ;
  LandPlanningAddRightBottomPointChanged(this.point);
  @override
  List<Object> get props =>[point];
}

class LandPlanningAddSubmitted extends LandPlanningAddEvent{
   LandPlanningAddSubmitted();
}

