import 'package:flutter/material.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';

class HeadingTextWidget extends StatelessWidget {
  const HeadingTextWidget({required this.text, Key? key}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: const BoxDecoration(
          border:
              Border(left: BorderSide(color: AppColors.appGreen1, width: 2.5))),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline5?.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: "Montserrat",
              fontSize: 18,
            ),
      ),
    );
  }
}
