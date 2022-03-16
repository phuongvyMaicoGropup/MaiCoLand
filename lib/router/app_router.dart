import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/model/entities/address.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/presentation/screens/auth_screen/login_screen.dart';
import 'package:maico_land/presentation/screens/auth_screen/register_screen.dart';
import 'package:maico_land/presentation/screens/home_screen/home_screen.dart';
import 'package:maico_land/presentation/screens/land_planning/land_planning_screen/land_planning_add_screen.dart';
import 'package:maico_land/presentation/screens/news/news_add/news_add_screen.dart';
import 'package:maico_land/presentation/screens/news/news_details/news_details_screen.dart';
import 'package:maico_land/presentation/screens/news/news_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final userRepo = UserRepository();
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/login':
        return MaterialPageRoute(
            builder: (_) => LoginScreen(
                  userRepo: userRepo,
                ));
      case '/register':
        return MaterialPageRoute(
            builder: (_) => RegisterScreen(userRepo: userRepo));
      case '/news':
        return MaterialPageRoute(builder: (_) => NewsScreen());

      case '/news/add':
        return MaterialPageRoute(builder: (_) => const NewsAddScreen());
      case '/landplanning/add':
        Address address = routeSettings.arguments as Address;
        return MaterialPageRoute(
            builder: (_) => LandPlanningAddScreen(address: address));
//       case '/landplannings':
//       return MaterialPageRoute(builder: (_)=> const LandPlanningsScreen());
//  case '/news':
//       return MaterialPageRoute(builder: (_)=> const NewsScreen());
      case '/news/details':
        var news = routeSettings.arguments as News;
        return MaterialPageRoute(builder: (_) => NewsDetailsScreen(news: news));
//         case '/account_settings':
//       return MaterialPageRoute(builder: (_)=> const AccountSettings());

//        case '/account':
//       return MaterialPageRoute(builder: (_)=>  AccountScreen());

//        case '/news/search':
//       return MaterialPageRoute(builder: (_)=>  NewsSearchScreen());
//       // case '/second':
//       //   return MaterialPageRoute(builder: (_)=> const SecondScreen(title: "Trang hai", color: Colors.redAccent));
//       // case '/third':
//       //   return MaterialPageRoute(builder: (_)=> const ThirdScreen(title: "Trang ba", color: Colors.yellowAccent));
      default:
        return null;
    }
  }
}
