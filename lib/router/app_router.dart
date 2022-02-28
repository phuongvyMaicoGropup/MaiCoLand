
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/presentation/screens/auth_screen/login_screen.dart';
import 'package:maico_land/presentation/screens/home_screen/home_screen.dart';

class AppRouter{
  Route? onGenerateRoute(RouteSettings routeSettings){
    
    switch(routeSettings.name){
      case '/login':
        final userRepo = UserRepository(); 
        return MaterialPageRoute(builder: (_)=> LoginScreen(userRepo: userRepo, ));
//       case '/register': 
//       return MaterialPageRoute(builder: (_)=> const RegisterScreen( ));
//       case '/news/add': 
//       return MaterialPageRoute(builder: (_)=> const NewsAddScreen());
//       case '/landplannings': 
//       return MaterialPageRoute(builder: (_)=> const LandPlanningsScreen());
//  case '/news': 
//       return MaterialPageRoute(builder: (_)=> const NewsScreen());
//       case '/news/details':
//         var news = routeSettings.arguments as News;
//         return MaterialPageRoute(builder: (_) => NewsDetailsScreen(news: news));
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
      default: return null;
    }
  }

}