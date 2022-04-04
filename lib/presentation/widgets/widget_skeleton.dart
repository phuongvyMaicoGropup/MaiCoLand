import 'package:flutter/material.dart';

class WidgetSkeleton extends StatelessWidget {
  const WidgetSkeleton({Key? key, this.height, this.width}) : super(key: key);
  final double? height, width;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            borderRadius: const BorderRadius.all(Radius.circular(8))));
  }
}
