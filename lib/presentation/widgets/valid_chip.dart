import 'package:flutter/material.dart';
import 'package:maico_land/presentation/styles/styles.dart';

class ValidChip extends StatelessWidget {
  const ValidChip({required this.expirationDate, Key? key}) : super(key: key);
  final DateTime expirationDate;
  @override
  Widget build(BuildContext context) {
    bool valDate = DateTime.now().isBefore(expirationDate);
    return valDate
        ? Container(
            padding: const EdgeInsets.all(3),
            child: const Text("Còn hiệu lực", style: textMinorGreen))
        : Container(
            padding: const EdgeInsets.all(3),
            child: const Text("Hết hiệu lực", style: textMinorRed));
  }
}
