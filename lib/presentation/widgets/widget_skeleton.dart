import 'package:flutter/material.dart';

class WidgetSkeleton extends StatelessWidget {
  const WidgetSkeleton({Key? key, this.height, this.width}) : super(key: key);
  final double? height, width;
  @override
  Widget build(BuildContext context) {
    // return AnimatedContainer(
    //   // Use the properties stored in the State class.
    //   width: width,
    //   height: height,
    //   decoration: BoxDecoration(
    //     color: Colors.black.withOpacity(0.04),
    //     borderRadius: const BorderRadius.all(Radius.circular(8)),
    //   ),
    //   // Define how long the animation should take.
    //   duration: const Duration(seconds: 1),
    //   // Provide an optional curve to make the animation feel smoother.
    //   curve: Curves.fastOutSlowIn,
    // );

    return Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.04),
            borderRadius: const BorderRadius.all(Radius.circular(8))));
  }
}
