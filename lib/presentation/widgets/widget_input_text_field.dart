import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class WidgetInputTextField extends StatelessWidget {
  WidgetInputTextField(
      {required this.icon,
      required this.labelText,
      required this.inputController,
      Key? key})
      : super(key: key);
  final IconData icon;
  final String labelText;
  final TextEditingController inputController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controller: inputController,
      decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.black26),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(color: Colors.black26),
          //   borderRadius: BorderRadius.circular(30.0),
          // ),
          contentPadding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
          ),
          labelText: labelText,
          labelStyle: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          )),
    );
  }
}
