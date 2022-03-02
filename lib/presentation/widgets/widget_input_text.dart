import 'package:flutter/material.dart';
import 'package:maico_land/presentation/styles/styles.dart';

class WidgetInputText extends StatelessWidget {
  const WidgetInputText(
      {required this.icon,
      required this.labelText,
      required this.controller,
      required this.maxLines,
      required this.function,
      Key? key})
      : super(key: key);
  final IconData icon;
  final String labelText;
  final TextEditingController controller; //
  final int maxLines;
  final Function function; 
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black87,
        fontWeight: FontWeight.w400,
      ),
      onChanged: (value)=> function,
      controller: controller,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black26),
            borderRadius: BorderRadius.circular(4.0),
          ),
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: AppColors.appGreen1)),
          labelText: labelText,
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: AppColors.red)),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: AppColors.red)),
          errorStyle: TextStyle(fontSize: 10, color: AppColors.red),
          focusColor: AppColors.appGreen1,
          contentPadding: const EdgeInsets.only(
            top: 10.0,
            left: 10.0,
            right: 10.0,
          )),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng không được để trống!';
        }
        return null;
      },
    );
  }
}
