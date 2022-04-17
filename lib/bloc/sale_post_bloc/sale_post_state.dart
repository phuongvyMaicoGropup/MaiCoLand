import 'package:equatable/equatable.dart';
import 'package:maico_land/model/formz_model/path_image.dart';

class SalePostState extends Equatable {
  // TODO: implement props
  final PathImage images;

  const SalePostState({
    this.images = const PathImage.pure(),
  });
  @override
  List<Object?> get props => [images];

  SalePostState copyWith({
    PathImage? images,
  }) {
    return SalePostState(
      images: images ?? this.images,
    );
  }
}
