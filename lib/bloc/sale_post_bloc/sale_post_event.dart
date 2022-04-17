import 'package:equatable/equatable.dart';
import 'package:maico_land/model/entities/address.dart';
import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;

abstract class SalePostEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SalePostImageChanged extends SalePostEvent {
  final List<String> images;
  SalePostImageChanged(this.images);
  @override
  List<Object> get props => [images];
}

class SalePostAddInitial extends SalePostEvent {}
