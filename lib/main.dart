
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_app/logic/blocs/login_bloc/login_bloc.dart';
import 'package:land_app/logic/blocs/register_bloc/register_bloc.dart';
import 'package:land_app/presentation/router/app_router.dart';

import 'presentation/resources/resources.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
   final AppRouter appRouter ;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers : [
        BlocProvider<LoginBloc>(
          create: (context)=> LoginBloc(),
        ),
        BlocProvider<RegisterBloc>(
          create: (context)=> RegisterBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: _kAppTheme,
        onGenerateRoute: appRouter.onGenerateRoute,


      ),
    );
  }
}

final ThemeData _kAppTheme = _buildAppTheme();

ThemeData _buildAppTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.appGreen1,
      onPrimary: AppColors.appGreen2,
      secondary:AppColors.appGreen3,
      error: AppColors.appErrorRed,
    ),
    textTheme: _buildAppTextTheme(base.textTheme),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: AppColors.appGreen1,
    ),
  );
}

TextTheme _buildAppTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline1: base.headline1!.copyWith(
          fontSize: 30.0,
        ),
        headline5: base.headline5!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        headline6: base.headline6!.copyWith(
          fontSize: 18.0,
        ),
        caption: base.caption!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyText1: base.bodyText1!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        )
      )
      .apply(
        fontFamily: 'Montsterrat',
        displayColor: Colors.black,
        bodyColor: Colors.black,
      );
}
