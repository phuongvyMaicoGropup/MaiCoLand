
import 'package:flutter/material.dart';
class LabelWidget extends StatelessWidget {
  const LabelWidget({ required this.label, Key? key }) : super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Text(label,
        textAlign: TextAlign.left,
        style: const TextStyle(

            height: 1.4,
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16.5,
            fontFamily: 'Montserrat',
            letterSpacing: 0.2));
  }
}
 