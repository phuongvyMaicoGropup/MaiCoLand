import 'package:flutter/material.dart';

import 'app_colors.dart';

const minorText = TextStyle(
  color: Color.fromRGBO(128, 128, 128, 1),
  fontSize: 16,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.normal,
);

const minorTextBold = TextStyle(
  color: Color.fromRGBO(128, 128, 128, 1),
  fontSize: 16,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.bold,
);

const smallText = TextStyle(
  color: Colors.grey,
  fontSize: 12,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.normal,
);

const minorTextWhite = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.normal,
);

const headingText = TextStyle(
  color: AppColors.black,
  fontSize: 24,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.bold,
);

const headingTextWhite = TextStyle(
  color: AppColors.white,
  fontSize: 26,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.bold,
);

const descriptionText = TextStyle(
  color: Colors.black,
  fontSize: 12,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w300,
);

const mediumText = TextStyle(
  color: AppColors.black,
  fontSize: 14,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
);

const headingText1 = TextStyle(
  color: AppColors.black,
  fontSize: 30,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.bold,
);

const whiteText = TextStyle(
  color: AppColors.white,
  fontSize: 16,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.normal,
);

const boldTextMedium = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

const textMedium = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
);
const textMediumWhite =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white);
const textMediumGreen = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.appGreen1);
const textMediumBlack = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.black);
const textLargeBlack = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.appGreen2);
const textLargeGreen = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.black);
const textMinorBlack = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.black);

const textMinorGreen = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.appGreen2);

const textMinorRed =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.red);
const textNormalBlack = TextStyle(
    fontWeight: FontWeight.normal, fontSize: 16, color: AppColors.black);
const textMiniBlack = TextStyle(
    fontWeight: FontWeight.normal, fontSize: 14, color: AppColors.black);
const textMiniBlackBold = TextStyle(
    fontWeight: FontWeight.normal, fontSize: 14, color: AppColors.black);
// Button Style

// const defaultButton = ButtonStyle(
//   backgroundColor: Colors.white,
//   minimumSize: Size(240, 80),
// );

const textMinorGrayTitle = TextStyle(
    color: Color(0xFF9899A0), fontSize: 14, fontWeight: FontWeight.bold);

const textMinorItalicGreen = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 12,
    color: AppColors.appGreen1,
    fontStyle: FontStyle.italic);

BoxDecoration boxBorderGray = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: Colors.grey.withOpacity(0.15),
  boxShadow: const [
    BoxShadow(color: Colors.white, spreadRadius: 1),
  ],
);
BoxDecoration boxBorderWhite = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: Colors.white,
);
BoxDecoration boxBorderGreen = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: AppColors.appGreen1,
);

BoxDecoration boxBorderDefault = BoxDecoration(
    borderRadius: BorderRadius.circular(4),
    border: Border.all(width: 1.0, color: Colors.black26));

BoxDecoration boxBorderWhiteWithGreenLine = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  border: Border.all(
      color: Colors.green, // set border color
      width: 1.0),
);

