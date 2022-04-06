import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String userName;
  final String email;
  final String fullName;
  final String photoURL;
  final String phoneNumber;
  final DateTime birthDate;
  final String address;
  final String bio;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.fullName,
    required this.photoURL,
    required this.phoneNumber,
    required this.address,
    required this.bio,
    required this.birthDate,
  });

  @override
  String toString() {
    return 'User(id: $id, userName: $userName, email: $email,  photoURL: $photoURL, phoneNumber: $phoneNumber)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        userName,
        fullName,
        photoURL,
        email,
        phoneNumber,
        address,
        bio,
        birthDate
      ];
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
