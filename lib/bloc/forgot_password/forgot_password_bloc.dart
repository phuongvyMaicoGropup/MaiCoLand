import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/forgot_password/forgot_password_event.dart';
import 'package:maico_land/bloc/forgot_password/forgot_password_state.dart';
import 'package:maico_land/model/api/firebase_manager/firebase_manager.dart';

import 'package:maico_land/model/formz_model/code.dart';
import 'package:maico_land/model/formz_model/password.dart';
import 'package:maico_land/model/formz_model/phone.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/presentation/styles/styles.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(const ForgotPasswordState()) {
    on<ForgotPasswordPhoneChanged>(_onPhoneChange);
    on<ForgotPasswordCodeChanged>(_onCodeChange);
    on<ForgotPasswordPasswordChanged>(_onPasswordChange);
    on<ForgotPasswordReNewPasswordChanged>(_onRePasswordChange);
    on<SubmitPhone>(_onPhoneSubmitted);
    on<SubmitPassword>(_onPasswordSubmitted);
    on<SubmitCode>(_onCodeSubmitted);
    on<ForgotPasswordInitial>(_onInitial);
  }
  FirebaseManager firebaseManager = FirebaseManager();
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
        ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
          content:
              Text("Số điện thoại không trùng khớp với bất kì tài khoản nào !"),
          backgroundColor: AppColors.appErrorRed,
          duration: Duration(milliseconds: 1000),
        ));
      } else {
        await firebaseManager.SendSMSVerified(event.context, state.phone.value)
            .then((value) {
          emit(state.copyWith(
              userName: userName,
              isCheckedPhone: CheckVariable.success,
              isLoading: Loading.notloading));
        });
      }
    }
  }

  Future<void> _onCodeSubmitted(
      SubmitCode event, Emitter<ForgotPasswordState> emit) async {
    bool checkValidCode = false;

    if (!state.code.invalid) {
      emit(state.copyWith(isLoading: Loading.loading));
      checkValidCode =
          await firebaseManager.CheckOTPCode(event.context, state.code.value);
      if (checkValidCode) {
        emit(state.copyWith(
            isCheckedCode: CheckVariable.success,
            isLoading: Loading.notloading));
        print("hoàn thành");
      } else {
        emit(state.copyWith(
            isCheckedCode: CheckVariable.failure,
            isLoading: Loading.notloading));
        ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
          content: Text("Mã OTP sai"),
          backgroundColor: AppColors.appErrorRed,
          duration: Duration(milliseconds: 1000),
        ));
      }
    }
  }

  Future<void> _onPasswordSubmitted(
      SubmitPassword event, Emitter<ForgotPasswordState> emit) async {
    bool check = false;
    if (!state.password.invalid) {
      emit(state.copyWith(isLoading: Loading.loading));
      check = await userRepository.changePassword(
          phoneNumber: state.phone.value, password: state.password.value);
      if (check) {
        ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
          content: Text("Đổi mật khẩu thành công. Quay về màn hình đăng nhập"),
          backgroundColor: AppColors.green,
          duration: Duration(milliseconds: 1000),
        ));
        event.context.read<ForgotPasswordBloc>().add(ForgotPasswordInitial());
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.popAndPushNamed(event.context, "/login");
        });
      } else {
        ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
          content: Text("Đổi mật khẩu không thành công"),
          backgroundColor: AppColors.appErrorRed,
          duration: Duration(milliseconds: 1000),
        ));
      }
    }
  }
}
