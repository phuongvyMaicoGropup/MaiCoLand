import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:land_app/logic/blocs/account/account_bloc/account_bloc.dart';
import 'package:land_app/logic/blocs/blocs.dart';
import 'package:land_app/logic/blocs/home/home_news_bloc/news_bloc.dart';
import 'package:land_app/logic/blocs/news/news_bloc_index/news_bloc.dart';
import 'package:land_app/model/repository/authentication_repository.dart';
import 'package:land_app/model/repository/home_repository.dart';
import 'package:land_app/presentation/resources/resources.dart';
import 'package:land_app/presentation/router/app_router.dart';
import 'package:land_app/presentation/screens/account/account_screen.dart';
import 'package:land_app/presentation/screens/create_item/create_item_screen.dart';
import 'package:land_app/presentation/screens/news/news_screen.dart';
import 'package:land_app/presentation/screens/screens.dart';

class MyApp extends StatefulWidget {
  MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    CreateItemScreen(),
    AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    AuthenticationRepository authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) =>
                LoginBloc(authenticationRepository: authenticationRepository),
          ),
          BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(
                authenticationRepository: authenticationRepository),
          ),
          BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(
                  authenticationRepository: authenticationRepository)
                ..add((AppLoaded()))),
          BlocProvider<HomeBloc>(create: (context) {
            HomeRepository homeRepository = HomeRepository();
            return HomeBloc(homeRepository: homeRepository);
          }),
          BlocProvider<AccountBloc>(create: (context) {
            HomeRepository homeRepository = HomeRepository();
            return AccountBloc(authenticationRepo: authenticationRepository);
          }),
          BlocProvider<LandPlanningBloc>(create: (context) {
            return LandPlanningBloc();
          }),
          BlocProvider<NewsAddBloc>(
              create: (context) => NewsAddBloc(
                  authenticationRepository: authenticationRepository)),
          BlocProvider<HomeNewsBloc>(create: (context) => HomeNewsBloc()),
          BlocProvider<NewsBloc>(create: (context) => NewsBloc()),
        ],
        child: MaterialApp(
          color: AppColors.appGreen1,
          theme: _kAppTheme,
          onGenerateRoute: widget.appRouter.onGenerateRoute,
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              print(state.toString());
              if (state is AuthenticationInitial) {
                return SplashScreen();
              } else if (state is AuthenticationNotAuthenticated) {
                return const LoginScreen();
              } else if (state is AuthenticationAuthenticated) {
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

              return Container(
                child: Center(child: Text('Unhandle State $state')),
              );
            },
          ),
        ));
  }

  void _addNewPost() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Chọn loại bài đăng!'),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/trade.png',
                        width: 115,
                      ),
                      const Text('Buôn bán'),
                    ],
                  )),
              TextButton(
                onPressed: () {
                  // Navigator.of(context, rootNavigator: true).pop();
                  Navigator.of(context).pushNamed("/news/add");
                },
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/news.png',
                      width: 115,
                    ),
                    const Text('Tin tức'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20)
        ],
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
