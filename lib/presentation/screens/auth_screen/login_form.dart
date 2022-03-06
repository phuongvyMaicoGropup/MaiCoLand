import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/login_bloc/login.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/presentation/screens/auth_screen/register_screen.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';
import 'package:maico_land/presentation/styles/theme.dart';
import 'package:maico_land/presentation/widgets/widget_input_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({required this.userRepo, Key? key}) : super(key: key);
  final UserRepository userRepo;

  @override
  _LoginFormState createState() => _LoginFormState(userRepo);
}

class _LoginFormState extends State<LoginForm> {
  final UserRepository userRepo;
  _LoginFormState(this.userRepo);
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool rememberMe = false;

  // get size => Media?

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text,
          rememberMe: rememberMe));
    }

    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailure) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Đăng nhập thất bại'), backgroundColor: Colors.red));
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Center(
            child: Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: Form(
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15),
                      Image(
                          image: AssetImage('assets/logo.png'),
                          height: MediaQuery.of(context).size.height * 0.2),
                      const SizedBox(height: 10),
                      WidgetInputTextField(
                        icon: EvaIcons.people,
                        labelText: "Tên đăng nhập",
                        inputController: _usernameController,
                      ),
                      const SizedBox(height: 10),
                      WidgetInputTextField(
                        icon: EvaIcons.eyeOutline,
                        labelText: "Mật khẩu",
                        inputController: _passwordController,
                      ),
                      const SizedBox(height: 15),
                      Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                              child: Text('Quên mật khẩu!',
                                  style: AppTextTheme.minorTextBlack),
                              onTap: () {})),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Column(children: [
                          SizedBox(
                              height: 50,
                              child: state is LoginLoading
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                            child: SizedBox(
                                                height: 25,
                                                width: 25,
                                                child:
                                                    CupertinoActivityIndicator()))
                                      ],
                                    )
                                  : TextButton(
                                      child: Text("Đăng nhập"),
                                      onPressed: () {
                                        _onLoginButtonPressed();
                                      },
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor: AppColors.appGreen1,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 8),
                                      ),
                                    ))
                        ]),
                      ),
                      Center(
                          child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  child: Row(children: [
                                Text("Chưa có tài khoản ? "),
                                SizedBox(width: 5),
                                GestureDetector(
                                    child: Text("Đăng ký ngay"),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen(
                                                    userRepo: userRepo)),
                                      );
                                    }),
                              ]))))
                    ],
                  ),
                )),
          ),
        );
      },
    ));
  }
}
