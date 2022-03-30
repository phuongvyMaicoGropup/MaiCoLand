import 'package:flutter/material.dart';
import 'package:maico_land/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:maico_land/bloc/forgot_password/forgot_password_event.dart';
import 'package:maico_land/bloc/forgot_password/forgot_password_state.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';

import '../../styles/styles.dart';
import 'widgets/widget.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Center(
              child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  child: Container(
                height: MediaQuery.of(context).size.height,
                color: const Color.fromARGB(255, 224, 223, 223),
              )),
              Positioned(
                child: Container(
                    decoration: boxBorderWhite,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(10),
                    child: Form(
                      child: Column(
                        children: [
                          Image(
                              image: const AssetImage('assets/logo.png'),
                              height: MediaQuery.of(context).size.height * 0.2),
                          const SizedBox(height: 10),
                          state.isLoading == Loading.notloading
                              ? forgetPassContainer(state)
                              : const CircularProgressIndicator(),
                        ],
                      ),
                    )),
              )
            ],
          )),
        );
      },
    ));
  }

  Widget forgetPassContainer(ForgotPasswordState state) {
    return Container(
      child: Column(
        children: <Widget>[
          phoneContainer(context, state),
          codeContainer(context, state),
          changePasswordContainer(context, state),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget phoneContainer(BuildContext context, ForgotPasswordState state) {
    if (state.isCheckedPhone == CheckVariable.notCheck ||
        state.isCheckedPhone == CheckVariable.failure) {
      return Container(
        child: Column(
          children: <Widget>[
            const Align(
                child:
                    Text("Vui lòng nhập số điện thoại", style: textMediumGreen),
                alignment: Alignment.topLeft),
            Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        key: const Key('ForgetPassword_phoneInput_textField'),
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                        ),
                        onChanged: (value) => {
                          context
                              .read<ForgotPasswordBloc>()
                              .add(ForgotPasswordPhoneChanged(value))
                        },
                        controller: phoneController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black26),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          alignLabelWithHint: true,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide:
                                  BorderSide(color: AppColors.appGreen1)),
                          labelText: "Số điện thoại",
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: AppColors.red)),
                          errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: AppColors.red)),
                          errorStyle: const TextStyle(
                              fontSize: 10, color: AppColors.red),
                          focusColor: AppColors.appGreen1,
                          errorText: state.phone.invalid
                              ? 'Vui lòng nhập số điện thoại'
                              : null,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: const Text('Gửi Mã OTP',
                              style: TextStyle(color: Colors.white)),
                          key: const Key('Gui_submitField'),
                          onPressed: () {
                            if (state.phone.value.trim().isNotEmpty) {
                              context.read<ForgotPasswordBloc>().add(
                                  SubmitPhone(phoneController.text, context));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Vui lòng không để trống!"),
                                  backgroundColor: AppColors.appErrorRed,
                                  duration: Duration(milliseconds: 1000),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                          child: const Text("Đăng nhập", style: textMinorGreen),
                          onTap: () {
                            Navigator.popAndPushNamed(context, "/login");
                          }),
                    ]))
          ],
        ),
      );
    }
    return Container();
  }

  Widget codeContainer(BuildContext context, ForgotPasswordState state) {
    if (state.isCheckedPhone == CheckVariable.success &&
        (state.isCheckedCode == CheckVariable.notCheck ||
            state.isCheckedCode == CheckVariable.failure)) {
      return Container(
        child: Column(
          children: <Widget>[
            Align(
                child: Text("Chào,${state.userName}", style: textMediumGreen),
                alignment: Alignment.topLeft),
            const SizedBox(
              height: 20,
            ),
            const Align(
                child: Text(
                    "Vui lòng nhập mã chúng tôi vừa gửi đến số điện thoại của bạn :",
                    style: textMinorGreen),
                alignment: Alignment.topLeft),
            Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        key: const Key('CodeVerified_phoneInput_textField'),
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                        ),
                        onChanged: (value) => {
                          context
                              .read<ForgotPasswordBloc>()
                              .add(ForgotPasswordCodeChanged(value))
                        },
                        controller: codeController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black26),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          alignLabelWithHint: true,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide:
                                  BorderSide(color: AppColors.appGreen1)),
                          labelText: "Mã OTP",
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: AppColors.red)),
                          errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: AppColors.red)),
                          errorStyle: const TextStyle(
                              fontSize: 10, color: AppColors.red),
                          focusColor: AppColors.appGreen1,
                          errorText:
                              state.code.invalid ? 'Vui lòng nhập số ' : null,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: const Text('Xác Thực',
                              style: TextStyle(color: Colors.white)),
                          key: const Key('Gui_submitField'),
                          onPressed: () {
                            if (!state.code.value.trim().isEmpty) {
                              context.read<ForgotPasswordBloc>().add(
                                  SubmitCode(codeController.text, context));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Vui lòng không để trống!"),
                                  backgroundColor: AppColors.appErrorRed,
                                  duration: Duration(milliseconds: 1000),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                          child: const Text("Hủy", style: textMinorGreen),
                          onTap: () {
                            context
                                .read<ForgotPasswordBloc>()
                                .add(ForgotPasswordInitial());
                            phoneController.text = "";
                            codeController.text = "";
                          }),
                    ]))
          ],
        ),
      );
    }
    return Container();
  }

  Widget changePasswordContainer(
      BuildContext context, ForgotPasswordState state) {
    if (state.isCheckedCode == CheckVariable.success) {
      return Container(
        child: Column(
          children: <Widget>[
            const Align(
                child: Text("Nhập mật khẩu mới của bạn", style: textMinorGreen),
                alignment: Alignment.topLeft),
            Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        key: const Key('Password_phoneInput_textField'),
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                        ),
                        onChanged: (value) => {
                          context
                              .read<ForgotPasswordBloc>()
                              .add(ForgotPasswordPasswordChanged(value))
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black26),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          alignLabelWithHint: true,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide:
                                  BorderSide(color: AppColors.appGreen1)),
                          labelText: "Mật khẩu",
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: AppColors.red)),
                          errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: AppColors.red)),
                          errorStyle: const TextStyle(
                              fontSize: 10, color: AppColors.red),
                          focusColor: AppColors.appGreen1,
                          errorText: state.password.invalid
                              ? 'Mật khẩu ít nhất 8 chữ số bao gồm số , chữ cái thường , chữ cái in hoa và kí tự đặc biệt'
                              : null,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: const Text("Đổi mật khẩu",
                              style: TextStyle(color: Colors.white)),
                          key: const Key('DoiMatKhau_submitField'),
                          onPressed: () {
                            if (state.password.value.trim().isNotEmpty) {
                              context.read<ForgotPasswordBloc>().add(
                                  SubmitPassword(
                                      passwordController.text, context));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Vui lòng không để trống!"),
                                  backgroundColor: AppColors.appErrorRed,
                                  duration: Duration(milliseconds: 1000),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                          child: const Text("Hủy", style: textMinorGreen),
                          onTap: () {
                            context
                                .read<ForgotPasswordBloc>()
                                .add(ForgotPasswordInitial());
                            phoneController.text = "";
                            codeController.text = "";
                          }),
                    ]))
          ],
        ),
      );
    }
    return Container();
  }
}
