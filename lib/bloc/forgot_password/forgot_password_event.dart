import 'package:equatable/equatable.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';

abstract class ForgotPasswordEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ForgotPasswordPhoneChanged extends ForgotPasswordEvent {
  final String phone;
  ForgotPasswordPhoneChanged(this.phone);

  @override
  List<Object> get props => [phone];
}

class ForgotPasswordCodeChanged extends ForgotPasswordEvent {
  final String code;
  ForgotPasswordCodeChanged(this.code);
  @override
  List<Object> get props => [code];
}

class ForgotPasswordPasswordChanged extends ForgotPasswordEvent {
  final String password;
  ForgotPasswordPasswordChanged(this.password);
  @override
  List<Object> get props => [password];
}

class ForgotPasswordReNewPasswordChanged extends ForgotPasswordEvent {
  final String reNewPassword;
  ForgotPasswordReNewPasswordChanged(this.reNewPassword);
  @override
  List<Object> get props => [reNewPassword];
}

class SubmitPhone extends ForgotPasswordEvent {
  final String phone;
  BuildContext context;
  SubmitPhone(this.phone, this.context);
  @override
  List<Object> get props => [phone, context];
}

class SubmitCode extends ForgotPasswordEvent {
  final String code;
  BuildContext context;
  SubmitCode(this.code, this.context);
  @override
  List<Object> get props => [code, context];
}

class SubmitPassword extends ForgotPasswordEvent {
  final String password;
  BuildContext context;
  SubmitPassword(this.password, this.context);
  @override
  List<Object> get props => [password, context];
}

class ForgotPasswordInitial extends ForgotPasswordEvent {}
