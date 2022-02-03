import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';


@JsonSerializable()
class Category extends Equatable {
  // int id;
  String name;
  IconData icon;
  String link; 

  Category( this.name, this.icon, this.link);

 
  @override
  List<Object> get props => [ name, icon, link];

  @override
  String toString() {
    return 'Category{ name: $name, icon: $icon}';
  }
}
