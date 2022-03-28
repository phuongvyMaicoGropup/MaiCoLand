import 'package:flutter/material.dart';
import 'package:maico_land/presentation/styles/app_colors.dart';
import 'package:maico_land/presentation/styles/app_themes.dart';

class TypeNewsChip extends StatelessWidget {
  const TypeNewsChip({required this.type, Key? key}) : super(key: key);

  final int type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 0:
        return Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: AppColors.appGreen1,
              border: Border.all(
                color: AppColors.appGreen1,
                width: 1,
              ),
            ),
            child: Text("Thị trường", style: whiteText.copyWith(fontSize: 10)));
      case 1:
        return Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              border: Border.all(
                color: Colors.redAccent,
                width: 1,
              ),
            ),
            child: Text("Chính sách", style: whiteText.copyWith(fontSize: 10)));
      case 2:
        return Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: AppColors.darkBlue,
              border: Border.all(
                color: AppColors.darkBlue,
                width: 1,
              ),
            ),
            child: Text("Quy hoạch", style: whiteText.copyWith(fontSize: 10)));
    }
    return Container();
  }
}
