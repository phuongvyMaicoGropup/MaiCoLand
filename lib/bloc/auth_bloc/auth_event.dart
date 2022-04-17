import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final String token;

  LoggedIn({required this.token});
  @override
  List<Object?> get props => [token];

  @override
  String toString() => "Logged in $token";
}

class LoggedOut extends AuthenticationEvent {}
