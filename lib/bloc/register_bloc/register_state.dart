part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.email = const Email.pure(),
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.phone = const Phone.pure(),
  });

  final Email email;
  final Username username;
  final Password password;
  final FormzStatus status;
  final FirstName firstName;
  final LastName lastName;
  final Phone phone;

  @override
  List<Object> get props =>
      [email, password, status, username, firstName, lastName, phone];

  RegisterState copyWith({
    Email? email,
    Username? username,
    Password? password,
    FormzStatus? status,
    FirstName? firstName,
    LastName? lastName,
    String? error,
    Phone? phone,
  }) {
    return RegisterState(
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
    );
  }
}
