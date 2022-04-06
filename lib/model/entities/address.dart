import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address extends Equatable {
  final String idLevel1;
  final String idLevel2;
  final String idLevel3;

  Address(
    this.idLevel1,
    this.idLevel2,
    this.idLevel3,
  );

  Address copyWith({
    String? idLevel1,
    String? idLevel2,
    String? idLevel3,
  }) {
    return Address(
      idLevel1 ?? this.idLevel1,
      idLevel2 ?? this.idLevel2,
      idLevel3 ?? this.idLevel3,
    );
  }

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  List<Object?> get props => [idLevel1, idLevel2, idLevel3];
}
