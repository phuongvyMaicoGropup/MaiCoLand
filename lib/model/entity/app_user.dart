import 'dart:convert';

import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String uid; 
  final String displayName; 
  final String email;
  final String photoURL; 
  final String phoneNumber;

  AppUser({
    required this.uid, 
    required this.displayName, 
    required this.email, 
    required this.photoURL, 
    required this.phoneNumber
    });

  @override
  // TODO: implement props
  List<Object> get props {
    return [
      uid,
      displayName,
      email,
      photoURL,
      phoneNumber,
    ];
  }
  

  AppUser copyWith({
    String? uid,
    String? displayName,
    String? email,
    String? photoURL,
    String? phoneNumber,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] ?? '',
      displayName: map['displayName'] ?? '',
      email: map['email'] ?? '',
      photoURL: map['photoURL'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) => AppUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppUser(uid: $uid, displayName: $displayName, email: $email, photoURL: $photoURL, phoneNumber: $phoneNumber)';
  }
}
