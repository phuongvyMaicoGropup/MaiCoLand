import 'package:flutter/material.dart';
import 'package:maico_land/presentation/styles/styles.dart';

class InputText extends StatelessWidget {
  InputText(
      {required this.controller,
      required this.label,
      required this.validator,
      required this.errorMessage,
      required this.width,
      required this.minLines,
      required this.maxLines,
      required this.inputType,
      Key? key})
      : super(key: key);

  TextEditingController controller;
  String label;
  String validator;
  String errorMessage;
  double width;
  int maxLines;
  int minLines;
  TextInputType inputType;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextFormField(
          maxLines: maxLines,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
          keyboardType: inputType,
          minLines: 1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
              labelText: label,
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
            if (!RegExp(validator).hasMatch(controller.text)) {
              return errorMessage;
            }
            return null;
          },
        )
      ]),
    );
  }
}
