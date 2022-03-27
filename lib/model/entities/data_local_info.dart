import 'dart:convert';

import 'package:equatable/equatable.dart';

class DataLocalInfo extends Equatable {
  final String name;
  final String id;

  const DataLocalInfo(
    this.name,
    this.id,
  );

  @override
  List<Object> get props => [name, id];

  DataLocalInfo copyWith({
    String? name,
    String? id,
  }) {
    return DataLocalInfo(
      name ?? this.name,
      id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
    };
  }

  factory DataLocalInfo.fromMap(Map<String, dynamic> map) {
    return DataLocalInfo(
      map['name'] ?? '',
      map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DataLocalInfo.fromJson(String source) =>
      DataLocalInfo.fromMap(json.decode(source));

  @override
  String toString() => 'DataLocalInfo(name: $name, id: $id)';
}
