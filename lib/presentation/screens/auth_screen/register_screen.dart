import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:maico_land/bloc/news_add_bloc/news_add_bloc.dart';
import 'package:maico_land/bloc/register_bloc/register_bloc.dart';
import 'package:maico_land/helpers/pick_file.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';
import 'package:maico_land/presentation/widgets/label_widget.dart';
import 'package:maico_land/presentation/widgets/widget_input_text.dart';
import 'package:maico_land/presentation/widgets/widget_input_text_field.dart';
import 'package:maico_land/presentation/widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({required this.userRepo, Key? key}) : super(key: key);
  final UserRepository userRepo;
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? imagePath;
  List<String> hashTags = [];
  final registerFormKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final hashTagController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _buildContent()));
  }

  Widget _buildContent() {
    return SingleChildScrollView(
        child: Form(
      key: registerFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
            Image(
                image: const AssetImage('assets/logo.png'),
                height: MediaQuery.of(context).size.height * 0.2),
            const SizedBox(height: 15),
            UserNameInput(usernameController),
            const SizedBox(height: 15),
            _FirstNameInput(firstNameController),
            const SizedBox(height: 15),
            _LastNameInput(lastNameController),
            const SizedBox(height: 15),
            _EmailInput(emailController),
            const SizedBox(height: 15),
            _PasswordInput(passwordController),
            const SizedBox(height: 15),
            _RegisterButton(),
            const SizedBox(height: 10),
            Container(
                alignment: Alignment.topRight,
                child: GestureDetector(
                    child: const Text("Đăng nhập ngay",
                        style: TextStyle(
                            fontSize: 12, color: AppColors.appGreen1)),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("/login", (route) => false);
                    })),
          ],
        ),
      ),
    ));
  }
}

class _FirstNameInput extends StatelessWidget {
  _FirstNameInput(this.controller);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return TextFormField(
          key: const Key('RegisterForm_firstNameInput_textField'),
          maxLines: 1,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
          onChanged: (value) =>
              context.read<RegisterBloc>().add(RegisterFirstNameChanged(value)),
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.circular(4.0),
            ),
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.appGreen1)),
            labelText: "Tên",
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.red)),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.red)),
            errorStyle: TextStyle(fontSize: 10, color: AppColors.red),
            focusColor: AppColors.appGreen1,
            errorText: state.firstName.invalid
                ? 'Vui lòng nhập trên 4 kí tự (không chứa dấu cách)!'
                : null,
          ),
        );
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  _LastNameInput(this.controller);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return TextFormField(
          key: const Key('RegisterForm_lastNameInput_textField'),
          maxLines: 1,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
          onChanged: (value) =>
              context.read<RegisterBloc>().add(RegisterLastNameChanged(value)),
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.circular(4.0),
            ),
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.appGreen1)),
            labelText: "Họ",
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.red)),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.red)),
            errorStyle: TextStyle(fontSize: 10, color: AppColors.red),
            focusColor: AppColors.appGreen1,
            errorText: state.lastName.invalid
                ? 'Vui lòng nhập trên 4 kí tự (không chứa dấu cách)!'
                : null,
          ),
        );
      },
    );
  }
}

class UserNameInput extends StatelessWidget {
  UserNameInput(this.controller);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextFormField(
          key: const Key('RegisterForm_usernameInput_textField'),
          maxLines: 1,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
          onChanged: (value) =>
              context.read<RegisterBloc>().add(RegisterUsernameChanged(value)),
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.circular(4.0),
            ),
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.appGreen1)),
            labelText: "Tên đăng nhập",
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.red)),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.red)),
            errorStyle: TextStyle(fontSize: 10, color: AppColors.red),
            focusColor: AppColors.appGreen1,
            errorText: state.username.invalid
                ? 'Vui lòng nhập trên 4 kí tự (không chứa dấu cách)!'
                : null,
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  _EmailInput(this.controller);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          key: const Key('RegisterForm_EmailInput_textField'),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
          onChanged: (value) =>
              context.read<RegisterBloc>().add(RegisterEmailChanged(value)),
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.circular(4.0),
            ),
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.appGreen1)),
            labelText: "Email",
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.red)),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.red)),
            errorStyle: TextStyle(fontSize: 10, color: AppColors.red),
            focusColor: AppColors.appGreen1,
            errorText:
                state.email.invalid ? 'Vui lòng nhập đúng định dạng!' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  _PasswordInput(this.controller);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          key: const Key('RegisterForm_PasswordInput_textField'),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
          onChanged: (value) =>
              context.read<RegisterBloc>().add(RegisterPasswordChanged(value)),
          controller: controller,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.circular(4.0),
            ),
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.appGreen1)),
            labelText: "Mật khẩu ",
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.red)),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: AppColors.red)),
            errorStyle: TextStyle(fontSize: 10, color: AppColors.red),
            focusColor: AppColors.appGreen1,
            errorText: state.password.invalid
                ? 'Mật khẩu ít nhất 8 chữ số bao gồm số , chữ cái thường , chữ cái in hoa và kí tự đặc biệt'
                : null,
          ),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('RegisterForm_continue_raisedButton'),
          child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.06,
              child: const Text('Đăng ký tài khoản',
                  style: TextStyle(color: Colors.white))),
          onPressed: state.status.isValidated
              ? () async {
                  try {
                    context.read<RegisterBloc>().add(RegisterSubmitted());
                    if (state.status.isSubmissionSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Đăng ký tài khoản thành công"),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                              "Tên tài khoản hoặc email đã được đăng ký. Vui lòng kiểm tra thông tin!"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                            "Đăng ký không thành công . Vui lòng thủ lại!"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    print(e.toString());
                  }
                }
              : null,
        );
      },
    );
  }
}
