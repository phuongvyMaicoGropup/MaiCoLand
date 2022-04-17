import 'package:flutter/material.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';

class TextIcon extends StatelessWidget {
  const TextIcon(this.icon, this.text, {Key? key}) : super(key: key);

  final IconData? icon;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, size: 16),
      const SizedBox(width: 4),
      Text(text.toString(),
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: AppColors.appBlackMain)),
    ]);
  }
}
