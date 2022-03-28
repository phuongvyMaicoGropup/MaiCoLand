import 'package:flutter/material.dart';
import 'package:maico_land/presentation/styles/app_themes.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({required this.name, Key? key}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(16, 138, 45, 1),
      ),
      child: Text(name[0].toLowerCase(), style: headingTextWhite),
    );
  }
}
