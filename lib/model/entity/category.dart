import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';


@JsonSerializable()
class Category extends Equatable {
  // int id;
  String name;
  IconData icon;

  Category( this.name, this.icon);

 
  @override
  List<Object> get props => [ name, icon];

  @override
  String toString() {
    return 'Category{ name: $name, icon: $icon}';
  }
}
