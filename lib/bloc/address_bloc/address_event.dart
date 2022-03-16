import 'package:dvhcvn/dvhcvn.dart';
import 'package:equatable/equatable.dart';

abstract class AddressEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddressIdLevel1Selected extends AddressEvent {
  final Level1 item;
  AddressIdLevel1Selected({required this.item});
}
class AddressIdLevel2Selected extends AddressEvent {
  final Level2 item;
  AddressIdLevel2Selected({required this.item});
}
class AddressIdLevel3Selected extends AddressEvent {
  final Level3 item;
  AddressIdLevel3Selected({required this.item});
}
