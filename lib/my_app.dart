import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/auth_bloc/auth.dart';
import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/model/entities/user.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/model/responses/user_reponse.dart';
import 'package:maico_land/presentation/screens/home_screen/home_screen.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';
import 'package:maico_land/router/app_router.dart';

import 'model/entities/GeoPoint.dart';
import 'presentation/screens/account/account_screen.dart';
import 'presentation/screens/auth_screen/login_screen.dart';
import 'presentation/screens/auth_screen/register_screen.dart';
import 'presentation/screens/create_option_screen/create_option_screen.dart';
import 'presentation/screens/land_planning/land_planning_detail_screen/land_planning_detail_screen.dart';
import 'presentation/screens/land_planning/land_planning_detail_screen/land_planning_details_screen.dart';
import 'presentation/screens/news/news_add/news_add_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({required this.appRouter, required this.userRepo, Key? key})
      : super(key: key);
  final UserRepository userRepo;
  final AppRouter appRouter;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  int _selectedIndex = 0;
//   accessToken
// "pk.eyJ1IjoiYW5kcmVhdHJhbjIwMDIiLCJhIjoiY2t4aXZndmk0NTFodTJwbXVlbXJpNnM0dyJ9.fOnQcO_C_2T8wlNCzIWzwQ"
// content
// "Chưa có thông tin"
// dateCreated
// January 2, 2022 at 12:00:00 AM UTC+7
// imageUrl
// "https://firebasestorage.googleapis.com/v0/b/tinevyland.appspot.com/o/images%2Fphuquoc.png%20(3).png?alt=media&token=834de6b7-3b65-4305-8eb5-d670da4bba27"
// isValidated
// true
// leftBotton
// [10.006904668867175° N, 103.980668° E]
// leftTop
// [10.085334° N, 103.980668° E]
// mapUrl
// "https://api.mapbox.com/styles/v1/andreatran2002/ckxjye6d2kw0p15o562zzeg4g/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYW5kcmVhdHJhbjIwMDIiLCJhIjoiY2t4aXZndmk0NTFodTJwbXVlbXJpNnM0dyJ9.fOnQcO_C_2T8wlNCzIWzwQ"
// rightBotton
// [10.006904668867175° N, 104.0368015904123° E]
// rightTop
// [10.085334° N, 104.036458° E]
// title
// "Quy hoạch đô thị An Thới huyện Phú Quốc tỉnh Kiên Giang"
// (string)

  final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    CreateOptionScreen(),
    AccountScreen(userRepo: UserRepository()),
    // DetailMapLandPlanning(
    //     landPlanning: LandPlanning(
    //         id: "123",
    //         title: "test",
    //         content: "Chuwa co thong tin",
    //         dateCreated: DateTime.now(),
    //         isValidated: true,
    //         leftBottom: GeoPoint(106.556801, 10.7399685),
    //         leftTop: GeoPoint(106.556801, 10.776478),
    //         rightBottom: GeoPoint(106.6087906, 10.7399533),
    //         rightTop: GeoPoint(106.6087906, 10.776478),
    //         imageUrl:
    //             "https://firebasestorage.googleapis.com/v0/b/maico-8490f.appspot.com/o/images%2F6292a378bf10704e2901.jpg?alt=media&token=b5b7874f-0c5e-48ca-bae4-f16796a90d23")),
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
        title: 'MaicoLand',
        theme: appTheme,
        onGenerateRoute: widget.appRouter.onGenerateRoute,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
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
            return RegisterScreen(userRepo: widget.userRepo);
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
