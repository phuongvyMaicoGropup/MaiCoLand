import 'package:flutter/material.dart';
import 'package:maico_land/presentation/widgets/widgets.dart';

Widget LandPlanningkeleton() {
  return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
        WidgetSkeleton(height: 105, width: 170),
        SizedBox(height: 8),
        WidgetSkeleton(width: 130, height: 20),
        SizedBox(height: 8),
        WidgetSkeleton(width: 40, height: 20),
      ]));
}
