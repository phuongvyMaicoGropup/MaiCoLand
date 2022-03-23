import 'package:flutter/material.dart';
import 'package:maico_land/presentation/styles/styles.dart';

class WidgetInputTextField extends StatelessWidget {
  const WidgetInputTextField(
      {required this.icon,
      required this.labelText,
      required this.inputController,
      required this.inputType,
      required this.visiblePassword,
      Key? key})
      : super(key: key);
  final IconData icon;
  final String labelText;
  final TextInputType inputType;
  final TextEditingController inputController;
  final bool visiblePassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      keyboardType: inputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == "") {
          return "Vui lòng không bỏ trống";
        } else {
          return null;
        }
      },
      obscureText: visiblePassword,
      controller: inputController,
      decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.black26),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(color: Colors.black26),
          //   borderRadius: BorderRadius.circulpar(30.0),
          // ),
          errorStyle: const TextStyle(fontSize: 10, color: AppColors.red),
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
