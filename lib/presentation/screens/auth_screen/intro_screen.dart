import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';
class IntroScreen extends StatefulWidget {
  final UserRepository userRepo;
  const IntroScreen({required this.userRepo, Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState(userRepo);
}

class _IntroScreenState extends State<IntroScreen> {
  final UserRepository userRepo;

  bool clicked = false; 
  void afterIntroComplete() {
    setState(() {
      clicked = true;
    });
  }
  final List<PageViewModel> pages = [
    PageViewModel(
      titleWidget: Column(children: const <Widget>
      [
        Text("hillo")
      ],)
    ),
    PageViewModel(
      titleWidget: Column(children: const <Widget>
      [
        Text("hillo2")
      ],)
    ),
  ];
  _IntroScreenState(this.userRepo);
  @override
  Widget build(BuildContext context) {
    return clicked ? Container(): IntroductionScreen(
      pages: pages,
      onDone: (){
        afterIntroComplete();
      },
      onSkip: (){
        afterIntroComplete();
      },
      skip: const Text("Bỏ qua"),
      showSkipButton: true,
      next: const Icon(Icons.navigate_next),
      done: const Text("Xong"),
      dotsDecorator:  DotsDecorator(
        size : const Size.square(7.0),
        activeSize: const Size(20.0,5.0),
        activeColor: AppColors.white,
      color : Colors.black26,
      spacing: const EdgeInsets.symmetric(
        horizontal: 3.0,
      ) ,
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      ),

    );
  }
}
