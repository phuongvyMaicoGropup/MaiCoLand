import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/auth_bloc/auth.dart';
import 'package:maico_land/bloc/register_bloc/register_bloc.dart';
import 'package:maico_land/model/repositories/home_repository.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/my_app.dart';
import 'package:maico_land/presentation/screens/home_screen/bloc/home_event.dart';

import 'bloc/news_add_bloc/news_add_bloc.dart';
import 'presentation/screens/auth_screen/login_screen.dart';
import 'presentation/screens/home_screen/bloc/home_bloc.dart';
import 'presentation/screens/home_screen/home_news_screen/bloc/news_bloc.dart';
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
          HomeRepository homeRepo = HomeRepository();
          HomeNewsBloc homeNewsBloc = HomeNewsBloc();
          return HomeBloc(homeRepository: homeRepo, newsBloc: homeNewsBloc)
            ..add(LoadHome());
        },
      ),
      BlocProvider(
        create: (context) {
          return HomeNewsBloc();
        },
      ),
      BlocProvider(
        create: (context) {
          return RegisterBloc(userRepo: userRepo);
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
