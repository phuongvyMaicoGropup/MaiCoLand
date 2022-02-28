import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/auth_bloc/auth.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/model/responses/user_reponse.dart';
import 'package:maico_land/presentation/screens/home_screen/home_screen.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';

import 'presentation/screens/auth_screen/login_screen.dart';
import 'presentation/screens/news/news_add/news_add_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({required this.userRepo, Key? key}) : super(key: key);
  final UserRepository userRepo;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const NewsAddScreen(),
    const HomeScreen(),
    // CreateItemScreen(),
    // AccountScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Deo',
        theme: appTheme,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            // UserReponse user = state.userReponse;
            // print(user);
            return SafeArea(
              child: Scaffold(
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  elevation: 0,
                  mouseCursor: SystemMouseCursors.grab,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.add_circle_outline),
                      label: 'Thêm tin',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle),
                      label: 'Account',
                    ),
                  ],
                  currentIndex: _selectedIndex, //New
                  onTap: _onItemTapped,
                ),
                body: Center(
                  child: _pages.elementAt(_selectedIndex), //New
                ),
              ),
            );
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginScreen(userRepo: widget.userRepo);
          }
          if (state is AuthenticationLoading) {
            return Scaffold(body: CircularProgressIndicator());
          }
          return Scaffold(body: CircularProgressIndicator());
        }));
  }
}

final ThemeData appTheme = _buildAppTheme();

ThemeData _buildAppTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.appGreen1,
        onPrimary: AppColors.white,
        secondary: AppColors.appGreen4,
        error: AppColors.appErrorRed,
      ),
      textTheme: _buildAppTextTheme(base.textTheme),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: AppColors.appGreen1,
      ),
      backgroundColor: AppColors.appGreen1);
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
          ))
      .apply(
        fontFamily: 'Montsterrat',
        displayColor: Colors.black,
        bodyColor: Colors.black,
      );
}
