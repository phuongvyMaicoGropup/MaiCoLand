// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      photoURL: json['photoURL'] as String,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String,
      bio: json['bio'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'email': instance.email,
      'fullName': instance.fullName,
      'photoURL': instance.photoURL,
      'phoneNumber': instance.phoneNumber,
      'birthDate': instance.birthDate.toIso8601String(),
      'address': instance.address,
      'bio': instance.bio,
    };
