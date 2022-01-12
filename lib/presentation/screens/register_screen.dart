import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:land_app/logic/blocs/login_bloc/login_bloc.dart';
import 'package:land_app/logic/blocs/register_bloc/register_bloc.dart';
import 'package:land_app/model/repository/authentication_repository.dart';
import 'package:land_app/presentation/resources/app_colors.dart';
import 'package:land_app/presentation/resources/app_themes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyContent(),
    );
  }

  Widget bodyContent() {
    return ListView(padding: const EdgeInsets.all(20.0), children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 30.0,
          ),
          const Image(image: AssetImage('assets/logo.png'), height: 150),
          const SizedBox(
            height: 30.0,
          ),
          _UsernameInput(),
          const SizedBox(
            height: 15,
          ),
          _EmailInput(),
          const SizedBox(
            height: 15.0,
          ),
          _PasswordInput(),
          const SizedBox(
            height: 20,
          ),

          const Align(
              alignment: Alignment.topRight, child: Text("Quên mật khẩu")),
          const SizedBox(
            height: 10,
          ),
          _RegisterButton(),
          const SizedBox(
            height: 18.0,
          ),
          Center(
            child: RichText(
                text: TextSpan(
                    text: 'Đã có tài khoản??',
                    style: minorText,
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamed("/login");
                        },
                      text: 'Đăng nhập',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline))
                ])),
          ),
          const SizedBox(
            height: 50.0,
          ),
          // const Center(child: Text('Hoặc đăng ký bằng')),
          const SizedBox(
            height: 30.0,
          ),
          // _loginWithSocicalNetwork(),
        ],
      ),
    ]);
  }

  // Widget _loginWithSocicalNetwork() {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: RaisedButton(
  //           padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 0.0),
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(8.0)),
  //           onPressed: () {},
  //           // color: AppColors.cornflowerBlue,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Icon(
  //                 Ionicons.logo_facebook,
  //                 color: Colors.white,
  //               ),
  //               SizedBox(
  //                 width: 10,
  //               ),
  //               Text(
  //                 R.strings.facebook,
  //                 style: whiteText,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       SizedBox(
  //         width: 16.0,
  //       ),
  //       Expanded(
  //         child: RaisedButton(
  //           padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 0.0),
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(8.0)),
  //           onPressed: () {},
  //           color: AppColors.indianRed,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Icon(
  //                 Ionicons.logo_google,
  //                 color: Colors.white,
  //               ),
  //               SizedBox(
  //                 width: 10,
  //               ),
  //               Text(
  //                 R.strings.google,
  //                 style: whiteText,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  void login() async {}

  // void createSnackBar(String message) {
  //   _scaffoldKey.currentState.(new SnackBar(content: new Text(message)));
  // }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('registerForm_emailInput_textField'),
          onChanged: (email) =>
              context.read<RegisterBloc>().add(RegisterEmailChanged(email)),
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: state.email.invalid
                ? 'Nhập theo cú pháp example@abc.xyz'
                : null,
          ),
        );
      },
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('registerForm_usernameInput_textField'),
          onChanged: (username) => context
              .read<RegisterBloc>()
              .add(RegisterUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: 'Tên người dùng',
            errorText: state.username.invalid
                ? 'Tên người dùng phải có hơn 3 kí tự! '
                : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('registerForm_passwordInput_textField'),
          onChanged: (password) => context
              .read<RegisterBloc>()
              .add(RegisterPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Mật khẩu',
            errorText:
                state.password.invalid ? 'Mật khẩu phải hơn 7 kí tự!!  ' : null,
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
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('registerForm_continue_raisedButton'),
                child: const Text(
                  'Đăng kí ',
                ),
                onPressed: state.status.isValidated
                    ? () async {
                        context.read<RegisterBloc>().add(RegisterSubmitted());
                        await AuthenticationRepository()
                            .signUp(
                                email: state.email.value,
                                password: state.password.value,
                                displayName: state.username.value)
                            .then((result) {
                          if (result == null) {
                            Navigator.of(context).pushNamed("/");
                          } else {
                            print("LOix : $result ");
                          }
                        });
                      }
                    : null,
              );
      },
    );
  }
}
