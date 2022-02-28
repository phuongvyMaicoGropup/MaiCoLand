import 'package:equatable/equatable.dart';
import 'package:maico_land/model/responses/user_reponse.dart';

abstract class AuthenticationState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final UserReponse userReponse;

  AuthenticationAuthenticated(this.userReponse); 
  List<Object?> get props => [userReponse];

}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}
