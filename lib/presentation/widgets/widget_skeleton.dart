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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.04),
            borderRadius: const BorderRadius.all(Radius.circular(8))));
  }
}

// class WidgetSkeleton extends StatefulWidget {
//   final double? height;
//   final double? width;

//   const WidgetSkeleton({Key? key, this.height = 20, this.width = 200})
//       : super(key: key);

//   @override
//   createState() => WidgetSkeletonState();
// }

// class WidgetSkeletonState extends State<WidgetSkeleton>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   late Animation gradientPosition;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//         duration: const Duration(milliseconds: 2000), vsync: this);

//     gradientPosition = Tween<double>(
//       begin: -5,
//       end: 10,
//     ).animate(
//       CurvedAnimation(
//           parent: _controller, curve: Curves.fastLinearToSlowEaseIn),
//     )..addListener(() {
//         setState(() {});
//       });

//     _controller.repeat();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.width,
//       height: widget.height,
//       decoration: BoxDecoration(
//           color: Colors.grey.withOpacity(0.9),
//           borderRadius: const BorderRadius.all(Radius.circular(8)),
//           gradient: LinearGradient(
//               begin: Alignment(gradientPosition.value, 0),
//               end: const Alignment(-1, 0),
//               colors: [
//                 Colors.black.withOpacity(0.1),
//                 Colors.black.withOpacity(0.2),
//                 Colors.black.withOpacity(0.1),
//               ])),
//     );
//   }
// }
