import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/auth_bloc/auth_bloc.dart';
import 'package:maico_land/bloc/login_bloc/login.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/presentation/screens/auth_screen/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({required this.userRepo, Key? key}) : super(key: key);
  final UserRepository userRepo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
              userRepo: userRepo,
              authBloc: BlocProvider.of<AuthenticationBloc>(context));
        },
        child: LoginForm(userRepo: userRepo),
      ),
    );
  }
}
