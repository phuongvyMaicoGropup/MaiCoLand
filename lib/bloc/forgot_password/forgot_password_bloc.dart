import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/forgot_password/forgot_password_event.dart';
import 'package:maico_land/bloc/forgot_password/forgot_password_state.dart';
import 'package:maico_land/model/entities/user.dart';

import 'package:maico_land/model/formz_model/code.dart';
import 'package:maico_land/model/formz_model/password.dart';
import 'package:maico_land/model/formz_model/phone.dart';
import 'package:maico_land/model/repositories/user_repository.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordState()) {
    on<ForgotPasswordPhoneChanged>(_onPhoneChange);
    on<ForgotPasswordCodeChanged>(_onCodeChange);
    on<ForgotPasswordPasswordChanged>(_onPasswordChange);
    on<ForgotPasswordReNewPasswordChanged>(_onRePasswordChange);
    on<SubmitPhone>(_onPhoneSubmitted);
    on<SubmitPassword>(_onPasswordSubmitted);
    on<SubmitCode>(_onCodeSubmitted);
    on<ForgotPasswordInitial>(_onInitial);
  }
  UserRepository userRepository = UserRepository();
  void _onInitial(
    ForgotPasswordInitial event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(state.copyWith(
        phone: const Phone.pure(),
        code: const Code.pure(),
        password: const Password.pure(),
        repassword: const Password.pure(),
        isCheckedCode: CheckVariable.notCheck,
        isLoading: Loading.notloading,
        isCheckedPhone: CheckVariable.notCheck,
        userName: ""));
  }

  void _onPhoneChange(
      ForgotPasswordPhoneChanged event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(
      phone: Phone.dirty(event.phone),
    ));
  }

  void _onCodeChange(
      ForgotPasswordCodeChanged event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(
      code: Code.dirty(event.code),
    ));
  }

  void _onPasswordChange(
      ForgotPasswordPasswordChanged event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(
      password: Password.dirty(event.password),
    ));
  }

  void _onRePasswordChange(ForgotPasswordReNewPasswordChanged event,
      Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(
      password: Password.dirty(event.reNewPassword),
    ));
  }

  Future<void> _onPhoneSubmitted(
      SubmitPhone event, Emitter<ForgotPasswordState> emit) async {
    if (!state.phone.invalid) {
      emit(state.copyWith(
          phone: Phone.dirty(event.phone), isLoading: Loading.loading));
      print(state.isLoading);
      String userName = await userRepository.getNameByPhone(event.phone);
      if (userName == "") {
        emit(state.copyWith(
            isCheckedPhone: CheckVariable.failure,
            isLoading: Loading.notloading));
      } else {
        emit(state.copyWith(
            userName: userName,
            isCheckedPhone: CheckVariable.success,
            isLoading: Loading.notloading));
        emit(state.copyWith(
            userName: userName,
            isCheckedPhone: CheckVariable.success,
            isLoading: Loading.notloading));
        print(state.isCheckedPhone);
      }
    }
  }

  void _onCodeSubmitted(SubmitCode event, Emitter<ForgotPasswordState> emit) {
    if (!state.code.invalid) {
      print(state.code);
    }
  }

  void _onPasswordSubmitted(
      SubmitPassword event, Emitter<ForgotPasswordState> emit) {
    if (!state.code.invalid) {
      print("oke");
    }
  }
}
