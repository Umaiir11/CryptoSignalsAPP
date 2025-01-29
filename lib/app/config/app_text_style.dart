// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';


abstract class AppTextStyles {
  AppTextStyles._();

  static TextStyle customText({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double fontSize = 12,
    double? height,
  }) {
    return GoogleFonts.aleo(
        fontSize: fontSize.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, height: height);
  }

  static textStyleTextBotton({bool? isUnderline = true}){
    return   TextStyle(
      decoration: (isUnderline?? true)?TextDecoration.underline: null,
      color: AppColors.white.withOpacity(0.5),
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter-Regular',
    );
  }

  static TextStyle customTextOswald({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double? height,
    double fontSize = 14,
  }) {
    return GoogleFonts.aleo(
        fontSize: fontSize, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, height: height);
  }
  static TextStyle customTextHinaMincho({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double? height,
    double fontSize = 14,
  }) {
    return GoogleFonts.aleo(
        fontSize: fontSize, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, height: height);
  }

  static TextStyle customTextInter({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double? height,
    double fontSize = 14,
  }) {
    return GoogleFonts.inter(
        fontSize: fontSize, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, height: height);
  }
  static TextStyle customText10({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double? height,
  }) {
    return GoogleFonts.aleo(
        fontSize: 10.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, height: height);
  }

  static TextStyle customText12({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double? height,
  }) {
    return GoogleFonts.aleo(
        fontSize: 12.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, height: height);
  }

  static TextStyle customText11({
    Color? color,
    TextDecoration? decoration,
    Color? decorationColor,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double? height,
  }) {
    return GoogleFonts.aleo(
        fontSize: 12.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, height: height, decoration: decoration, decorationColor: decorationColor);
  }

  static TextStyle customText14({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    TextDecoration decoration = TextDecoration.none,
    Color? decorationColor,
  }) {
    return GoogleFonts.aleo(
        fontSize: 14.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, decoration: decoration);
  } static TextStyle customText15({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    TextDecoration decoration = TextDecoration.none,
    Color? decorationColor,
  }) {
    return GoogleFonts.aleo(
        fontSize: 14.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, decoration: decoration);
  }

  static TextStyle customText16({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    TextDecoration decoration = TextDecoration.none,
    Color? decorationColor,
  }) {
    return GoogleFonts.aleo(
        fontSize: 16.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, decoration: decoration, decorationColor: decorationColor);
  }static TextStyle customText17({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    TextDecoration decoration = TextDecoration.none,
    Color? decorationColor,
  }) {
    return GoogleFonts.aleo(
        fontSize: 16.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, decoration: decoration, decorationColor: decorationColor);
  }

  static TextStyle customText18({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double? height,
  }) {
    return GoogleFonts.aleo(
        fontSize: 18.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, height: height);
  }

  static TextStyle customText20({
    List<Shadow>? shadow,
    Color? color,
    double? height,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.aleo(
        fontSize: 18.sp, height: height ,fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, shadows: shadow);
  }

  static TextStyle customText22({
    List<Shadow>? shadow,
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double? height,
  }) {
    return GoogleFonts.aleo(
        fontSize: 22.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, height: height, shadows: shadow);
  }

  static TextStyle customText24({
    List<Shadow>? shadow,
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.aleo(
        fontSize: 24.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, shadows: shadow);
  }

  static TextStyle customText26({
    List<Shadow>? shadow,
    double? height,
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.aleo(
        fontSize: 26.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, shadows: shadow, height: height);
  }

  static TextStyle customText28({
    List<Shadow>? shadow,
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.aleo(
        fontSize: 28.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, shadows: shadow);
  }static TextStyle customText30({
    List<Shadow>? shadow,
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.aleo(
        fontSize: 28.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, shadows: shadow);
  }
  static TextStyle customText32({
    List<Shadow>? shadow,
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
  }) {
    return GoogleFonts.aleo(
        fontSize: 28.sp, fontWeight: fontWeight, color: color, letterSpacing: letterSpacing, shadows: shadow);
  }

}
