import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:formz/formz.dart';
import 'package:maico_land/bloc/register_bloc/register_bloc.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/widget.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';

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
  final phoneController = TextEditingController();
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Image(
                image: const AssetImage('assets/logo.png'),
                height: MediaQuery.of(context).size.height * 0.2),
            const SizedBox(height: 15),
            UserNameInput(usernameController),
            const SizedBox(height: 15),
            FirstNameInput(firstNameController),
            const SizedBox(height: 15),
            LastNameInput(lastNameController),
            const SizedBox(height: 15),
            EmailInput(emailController),
            const SizedBox(height: 15),
            PhoneNumberInput(phoneController),
            const SizedBox(height: 15),
            PasswordInput(passwordController),
            const SizedBox(height: 15),
            RegisterButton(),
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
