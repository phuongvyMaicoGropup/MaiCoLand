import 'package:flutter/material.dart';

class WidgetSkeleton extends StatefulWidget {
  WidgetSkeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  State<WidgetSkeleton> createState() => _WidgetSkeletonState();
}

class _WidgetSkeletonState extends State<WidgetSkeleton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      _controller.forward().then((value) => _controller.reverse);
    }

    return FadeTransition(
      opacity: Tween(begin: 0.5, end: 1.0)
          .animate(CurvedAnimation(curve: Curves.easeIn, parent: _controller)),
      child: Container(
          height: widget.height,
          width: widget.width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              borderRadius: const BorderRadius.all(Radius.circular(8)))),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
