
import 'package:flutter/material.dart';
import 'package:land_app/presentation/widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

   openLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: COLOR_CONST.DEFAULT,
        child: Center(
          child: SizedBox(
            width: 240,
            child: LogoWidget(),
          ),
        ),
      ),
    );
  }

  void openLogin() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/login');
    });
  }
}