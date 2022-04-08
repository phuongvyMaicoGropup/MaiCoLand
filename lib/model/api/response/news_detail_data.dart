import 'package:equatable/equatable.dart';
import 'package:maico_land/model/entities/user.dart';

class NewsDetailData extends Equatable {
  final User user;
  final List<String> images;

  NewsDetailData(this.user, this.images);
  @override
  // TODO: implement props
  List<Object?> get props => [user, images];
}
