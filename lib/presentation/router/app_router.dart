
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:land_app/presentation/screens/land_plannings/land_plannings_screen.dart';
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

      // case '/second':
      //   return MaterialPageRoute(builder: (_)=> const SecondScreen(title: "Trang hai", color: Colors.redAccent));
      // case '/third':
      //   return MaterialPageRoute(builder: (_)=> const ThirdScreen(title: "Trang ba", color: Colors.yellowAccent));
      default: return null;
    }
  }

}