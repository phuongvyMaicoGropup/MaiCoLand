import 'dart:convert';

class User {
  final String id;
  final String userName;
  final String email;
  final String firstName;
  final String lastName;
  final String photoURL;
  final String phoneNumber;

  User(
      {required this.id,
      required this.userName,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.photoURL,
      required this.phoneNumber});

  User copyWith({
    String? id,
    String? userName,
    String? email,
    String? firstName,
    String? lastName,
    String? photoURL,
    String? phoneNumber,
  }) {
    return User(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      photoURL: photoURL ?? this.photoURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      userName: map['userName'] ?? '',
      email: map['email'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      photoURL: map['photoURL'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, userName: $userName, email: $email, firstName: $firstName, lastName: $lastName, photoURL: $photoURL, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.userName == userName &&
        other.email == email &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.photoURL == photoURL &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userName.hashCode ^
        email.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        photoURL.hashCode ^
        phoneNumber.hashCode;
  }
}
