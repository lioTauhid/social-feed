import 'package:flutter/material.dart';

// class AppColor {}

const Color primaryColor = Color(0xff03A9F4);
const Color secondaryColor = Color(0xff00BCD4);
const Color accentColor = Colors.orange;

Color textPrimary = const Color(0xff212121);
Color textSecondary = const Color(0xff757575);
Color primaryBackground = const Color(0xffF1F4F8);
Color secondaryBackground = const Color(0xffFFFFFF);
// Color alternate = const Color(0xff434343);

const Color red = Colors.red;
const Color white = Colors.white;
const Color black = Colors.black;

void applyThem(bool dark) {
  if (dark) {
    textPrimary = const Color(0xffFFFFFF);
    textSecondary = const Color(0xffD9D9D9);
    primaryBackground = const Color(0xff121212);
    secondaryBackground = const Color(0xff262626);
    // alternate = const Color(0xff434343);
  } else {
    textPrimary = const Color(0xff262626);
    textSecondary = const Color(0xff7B7B7B);
    primaryBackground = const Color(0xffF1F4F8);
    secondaryBackground = const Color(0xffFFFFFF);
    // alternate = const Color(0xffF5F5F5);
  }
}
