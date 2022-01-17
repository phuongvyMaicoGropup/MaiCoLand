import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:land_app/logic/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:land_app/logic/blocs/login_bloc/login_bloc.dart';
import 'package:land_app/model/repository/authentication_repository.dart';
import 'package:land_app/presentation/resources/app_colors.dart';
import 'package:land_app/presentation/resources/app_themes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthenticationBloc _authenticationBloc ; 
  AuthenticationRepository? _authenticationRepository ; 

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _authenticationRepository = RepositoryProvider.of<AuthenticationRepository>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context,state){
        print(state.status);
         if (state.status ==  FormzStatus.submissionInProgress){
           ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const[
                     Text('Processing ...'),
                     CircularProgressIndicator(),
                  ],
                ),
              )
           );
             
         }
         if (state.status == FormzStatus.submissionSuccess) {
          _authenticationBloc.add(UserLoggedIn(user : _authenticationRepository!.user));
          print(_authenticationBloc.toString());
        }
          if (state.status==FormzStatus.submissionFailure){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const[
                    Text('Login Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              )
           );
            
          
         }
      },
     child : Scaffold(
      body: bodyContent(),
    ));
  }

  Widget bodyContent() {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children:[ Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 30.0,
          ),
          const Image(image: AssetImage('assets/logo.png'),height : 150),
          const SizedBox(
            height: 30.0,
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
              alignment: Alignment.topRight,
              child: Text("Quên mật khẩu")),
          const SizedBox(
            height: 10,
          ),
          _LoginButton(),
          const SizedBox(
            height: 18.0,
          ),
          Center(
            child: RichText(
                text: TextSpan(
                    text: 'Don have account? ',
                    style: minorText,
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                         Navigator.of(context).pushNamed("/register");
                        },
                      text: 'Register',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline))
                ])),
          ),
          const SizedBox(
            height: 50.0,
          ),
          // const Center(child: Text('Or Login with')),
          const SizedBox(
            height: 30.0,
          ),
          // _loginWithSocicalNetwork(),
        ],
      ),
      ]
    );
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
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) =>
              context.read<LoginBloc>().add(LoginEmailChanged(email)),
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: state.email.invalid ? 'Invalid email!!' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Mật khẩu',
            errorText: state.password.invalid ? 'Mật khẩu không hợp lệ. Vui lòng nhập lại' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('loginForm_continue_raisedButton'),
          child: const Text('Đăng nhập', style : TextStyle(color : Colors.white)),
          onPressed: state.status.isValidated
              ? () {
            context.read<LoginBloc>().add(LoginSubmitted());
      
          }
              : null,
        );
      },
    );
  }
}
