import 'package:flutter/material.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/widget.dart';
import 'package:maico_land/presentation/styles/styles.dart';

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
                    margin: const EdgeInsets.all(10),
                    decoration: boxBorderWhite,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 20),
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
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
                        const SizedBox(height: 30),
                        Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                                child: const Text("Đăng nhập",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.appGreen1,
                                    )),
                                onTap: () {
                                  Navigator.of(context)
                                      .popAndPushNamed("/login");
                                })),
                      ],
                    ),
                  ),
                )
              ],
            ))));
  }
}
