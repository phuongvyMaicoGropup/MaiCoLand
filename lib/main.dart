import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/auth_bloc/auth.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/my_app.dart';

import 'bloc/news_add_bloc/news_add_bloc.dart';
import 'presentation/screens/auth_screen/login_screen.dart';
import 'presentation/screens/home_screen/home_screen.dart';

void main() {
  final UserRepository userRepo = UserRepository();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) {
          return AuthenticationBloc(userRepo: userRepo)..add(AppStarted());
        },
      ),
      BlocProvider(
        create: (context) {
          return NewsAddBloc(userRepository: userRepo);
        },
      )
    ], child: MyApp(userRepo: userRepo)),
  );
}
