part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class RegisterEmailChanged extends RegisterEvent{
  final String email;
  RegisterEmailChanged(this.email);
  @override
  List<Object> get props =>[email];
}

class RegisterPasswordChanged extends RegisterEvent{
  final String password;
  RegisterPasswordChanged(this.password);
  @override
  List<Object> get props =>[password];
}
class RegisterUsernameChanged extends RegisterEvent{
  final String username;
  RegisterUsernameChanged(this.username);
  @override
  List<Object> get props =>[username];
}
class RegisterSubmitted extends RegisterEvent{
   RegisterSubmitted();
}
