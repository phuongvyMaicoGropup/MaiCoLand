
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:land_app/model/entity/news.dart';
import 'package:land_app/presentation/screens/account/account_screen.dart';
import 'package:land_app/presentation/screens/account/account_settings_screen.dart';
import 'package:land_app/presentation/screens/land_plannings/land_plannings_screen.dart';
import 'package:land_app/presentation/screens/news/news_details/news_details_screen.dart';
import 'package:land_app/presentation/screens/news/news_screen.dart';
import 'package:land_app/presentation/screens/news/news_search/news_search_screen.dart';
import 'package:land_app/presentation/screens/screens.dart';   
class AppRouter{
  Route? onGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case '/':
        return MaterialPageRoute(builder: (_)=> const HomeScreen( )); 
      case '/login':
        return MaterialPageRoute(builder: (_)=> const LoginScreen( ));
      case '/register': 
      return MaterialPageRoute(builder: (_)=> const RegisterScreen( ));
      case '/news/add': 
      return MaterialPageRoute(builder: (_)=> const NewsAddScreen());
      case '/landplannings': 
      return MaterialPageRoute(builder: (_)=> const LandPlanningsScreen());
 case '/news': 
      return MaterialPageRoute(builder: (_)=> const NewsScreen());
      case '/news/details':
        var news = routeSettings.arguments as News;
        return MaterialPageRoute(builder: (_) => NewsDetailsScreen(news: news));
        case '/account_settings': 
      return MaterialPageRoute(builder: (_)=> const AccountSettings());

       case '/account': 
      return MaterialPageRoute(builder: (_)=>  AccountScreen());
      
       case '/news/search': 
      return MaterialPageRoute(builder: (_)=>  NewsSearchScreen());
      // case '/second':
      //   return MaterialPageRoute(builder: (_)=> const SecondScreen(title: "Trang hai", color: Colors.redAccent));
      // case '/third':
      //   return MaterialPageRoute(builder: (_)=> const ThirdScreen(title: "Trang ba", color: Colors.yellowAccent));
      default: return null;
    }
  }

}