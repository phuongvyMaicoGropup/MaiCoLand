import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maico_land/presentation/styles/app_themes.dart';
import 'dart:math' as math;

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({required this.name, Key? key}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      ),
      child: Text(name[0].toLowerCase(), style: headingTextWhite),
    );
  }
}
