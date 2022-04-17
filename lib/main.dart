import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:maico_land/bloc/address_bloc/address.dart';
import 'package:maico_land/bloc/auth_bloc/auth.dart';
import 'package:maico_land/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:maico_land/bloc/news_bloc/news_bloc.dart';
import 'package:maico_land/bloc/register_bloc/register_bloc.dart';
import 'package:maico_land/model/local/pref.dart';
import 'package:maico_land/model/repositories/land_repository.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
import 'package:maico_land/model/repositories/session_repository.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/my_app.dart';
import 'package:maico_land/presentation/styles/styles.dart';
import 'package:maico_land/router/app_router.dart';
import 'package:path_provider/path_provider.dart';
import 'bloc/news_add_bloc/news_add_bloc.dart';
import 'presentation/screens/home_screen/home_land_planning/bloc/land_planning_bloc.dart';
import 'presentation/screens/home_screen/home_news_screen/bloc/news_bloc.dart';
import 'presentation/screens/home_screen/home_news_top_viewed/bloc/top_news_bloc.dart';

Future<void> main() async {
  final UserRepository userRepo = UserRepository();
  final AppRouter router = AppRouter();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.appGreen2,
    systemNavigationBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<LandPlanningRepository>(
              create: (context) => LandPlanningRepository()),
          RepositoryProvider<NewsRepository>(
              create: (context) => NewsRepository()),
          RepositoryProvider<UserRepository>(
              create: (context) => UserRepository()),
          RepositoryProvider<SessionRepository>(
              create: (context) => SessionRepository(pref: LocalPref())),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) {
                  return AuthenticationBloc(userRepo: userRepo)
                    ..add(AppStarted());
                },
              ),
              BlocProvider(
                create: (context) {
                  return RegisterBloc(userRepo: userRepo);
                },
              ),
              BlocProvider(
                create: (context) {
                  return HomeNewsBloc()..add(LoadHomeNews());
                },
              ),
              BlocProvider(
                create: (context) {
                  return HomeLandPlanningBloc()..add(LoadHomeLandPlanning());
                },
              ),
              BlocProvider(
                create: (context) {
                  return NewsBloc(newsRepo: NewsRepository());
                },
              ),
              BlocProvider(
                create: (context) {
                  return TopNewsBloc(
                      newsRepo: RepositoryProvider.of<NewsRepository>(context))
                    ..add(LoadTopNews());
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
              ),
              BlocProvider(
                create: (context) {
                  return AddressBloc();
                },
              ),
              BlocProvider(
                create: (context) {
                  return ForgotPasswordBloc();
                },
              )
            ],
            child: MyApp(
              userRepo: userRepo,
              appRouter: router,
            )),
      ),
    ),
    storage: storage,
  );
}
