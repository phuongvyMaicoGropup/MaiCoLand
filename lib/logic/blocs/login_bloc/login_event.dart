part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class LoginEmailChanged extends LoginEvent{
  final String email;
  LoginEmailChanged(this.email);
  @override
  List<Object> get props =>[email];
}

class LoginPasswordChanged extends LoginEvent{
  final String password;
  LoginPasswordChanged(this.password);
  @override
  List<Object> get props =>[password];
}
class LoginSubmitted extends LoginEvent{
   LoginSubmitted();
}
