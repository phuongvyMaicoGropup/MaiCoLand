part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.email = const Email.pure(),
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,

  });

  final Email email;
  final Username username; 
  final Password password;
  final FormzStatus status;

  @override
  List<Object> get props => [email, password, status];

  RegisterState copyWith({
    Email? email,
    Username? username,
    Password? password,
    FormzStatus? status,
    
    String? error,
  }) {
    return RegisterState(
      email: email ?? this.email,
      username : username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}