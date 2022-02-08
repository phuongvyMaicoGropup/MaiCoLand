import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:land_app/presentation/resources/resources.dart';


@JsonSerializable()
class Category extends Equatable {
  // int id;
  String name;
  IconData icon;
  String link; 
  Color iconColor = AppColors.appGreen1; 

  Category( this.name, this.icon, this.link, this.iconColor);

 
  @override
  List<Object> get props => [ name, icon, link,iconColor];

  @override
  String toString() {
    return 'Category{ name: $name, icon: $icon}';
  }
}
