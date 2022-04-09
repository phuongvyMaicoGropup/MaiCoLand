import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maico_land/model/entities/address.dart';
import 'package:maico_land/model/entities/land_planning.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/presentation/screens/account_post/account_land.dart';
import 'package:maico_land/presentation/screens/account_post/account_news.dart';
import 'package:maico_land/presentation/screens/auth_screen/forget_password.dart';
import 'package:maico_land/presentation/screens/auth_screen/login_or_register.dart';
import 'package:maico_land/presentation/screens/auth_screen/login_screen.dart';
import 'package:maico_land/presentation/screens/auth_screen/register_screen.dart';
import 'package:maico_land/presentation/screens/home_screen/home_screen.dart';
import 'package:maico_land/presentation/screens/land_planning/land_planning_add_screen/land_planning_add_screen.dart';
import 'package:maico_land/presentation/screens/land_planning/land_planning_detail_screen/land_planning_details_screen.dart';
import 'package:maico_land/presentation/screens/land_planning/land_planning_screen/land_planning_screen.dart';
import 'package:maico_land/presentation/screens/news/news_add/news_add_screen.dart';
import 'package:maico_land/presentation/screens/news/news_details/news_details_screen.dart';
import 'package:maico_land/presentation/screens/news/news_screen.dart';
import 'package:maico_land/presentation/screens/save_screen/land_saved_screen.dart';
import 'package:maico_land/presentation/screens/save_screen/news_save_screen.dart';
import 'package:maico_land/presentation/screens/user_post/user_post_land.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
      case '/forgetpassword':
        return MaterialPageRoute(builder: (_) => const ForgetPassword());
      case '/loginorregister':
        return MaterialPageRoute(builder: (_) => const LoginOrRegister());
      case '/news':
        return MaterialPageRoute(builder: (_) => const NewsScreen());
      case '/userpostland':
        return MaterialPageRoute(builder: (_) => UserPostLand());
      case '/news/add':
        // int type = routeSettings.arguments as int;
        return MaterialPageRoute(builder: (_) => NewsAddScreen());
      case '/account/news':
        var id = routeSettings.arguments as String;
        return MaterialPageRoute(builder: (_) => AccountNews(authorId: id));
      case '/account/landplanning':
        var id = routeSettings.arguments as String;
        return MaterialPageRoute(builder: (_) => AccountLand(authorId: id));
      case '/landplanning/add':
        Address address = routeSettings.arguments as Address;
        return MaterialPageRoute(
            builder: (_) => LandPlanningAddScreen(address: address));
      case '/landplanning':
        return MaterialPageRoute(builder: (_) => const LandPlanningScreen());
      case '/news/save':
        return MaterialPageRoute(builder: (_) => const NewsSaveScreen());
      case '/landplanning/save':
        return MaterialPageRoute(builder: (_) => const LandSavedScreen());
      case '/landplanning/details':
        var land = routeSettings.arguments as LandPlanning;
        final controller = Completer<WebViewController>();

        // return MaterialPageRoute(
        // builder: (_) => LandPlanningDetailScreen(land: land));
        return MaterialPageRoute(
            builder: (_) => LandPlanningDetailMapScreen(
                controller: controller, landPlanning: land));
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
