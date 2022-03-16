import 'package:flutter/material.dart';
import 'package:maico_land/presentation/styles/styles.dart';

class InputPoint extends StatelessWidget {
  InputPoint(
      {required this.width,
      required this.label,
      required this.maxLines,
      required this.controllerX,
      required this.controllerY,
      required this.validator,
      required this.errorMessage,
      Key? key})
      : super(key: key);

  final double width;
  final String label;
  final int maxLines;
  TextEditingController controllerX;
  TextEditingController controllerY;
  final String validator;
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: TextStyle(fontSize: 10, color: AppColors.appGreen1)),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: width * 0.45,
              child: TextFormField(
                maxLines: maxLines,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.number,
                minLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controllerX,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    alignLabelWithHint: true,
                    label: const Text("Toạ độ x",
                        style: TextStyle(
                            fontSize: 10, color: AppColors.appGreen1)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: AppColors.appGreen1)),
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
                  if (!RegExp(validator).hasMatch(controllerX.text)) {
                    return errorMessage;
                  }
                  return null;
                },
              ),
            ),
            Container(
              width: width * 0.45,
              child: TextFormField(
                maxLines: maxLines,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.number,
                minLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controllerY,
                decoration: InputDecoration(
                    label: const Text("Toạ độ y",
                        style: TextStyle(
                            fontSize: 10, color: AppColors.appGreen1)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    alignLabelWithHint: true,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: AppColors.appGreen1)),
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
                  if (!RegExp(validator).hasMatch(controllerY.text)) {
                    return errorMessage;
                  }
                  return null;
                },
              ),
            )
          ],
        )
      ]),
    );
  }
}
