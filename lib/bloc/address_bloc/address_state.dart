
import 'package:dvhcvn/dvhcvn.dart';
import 'package:equatable/equatable.dart';

class AddressState extends Equatable {
  @override
  List<Object> get props => [level1, level2, level3];
  late Level1 level1;
  late Level2 level2;
  late Level3 level3;
  AddressState({
    required this.level1,
    required this.level2,
    required this.level3,
  });

  AddressState copyWith({
     Level1? level1,
     Level2? level2,
     Level3? level3,
  }) {
    return AddressState(
      level1: level1 ?? this.level1,
      level2: level2 ?? this.level2,
      level3: level3 ?? this.level3,
    );
  }

  @override
  String toString() => 'AddressState(level1: $level1, level2: $level2, level3: $level3)';
}
