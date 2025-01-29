import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';


import '../config/app_colors.dart';
import '../config/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Gradient? gradient;
  final double? borderRadius;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final Widget? icon;
  final bool isGradientEnabled;
  final Color? bgColor;
  final Color? borderColor;
  final GlobalKey? textKey;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.gradient,
    this.borderRadius ,
    this.height,
    this.width ,
    this.textStyle, this.icon, this.isGradientEnabled = true, this.bgColor, this.borderColor, this.textKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        onPressed();
      },
      child: Container(
        height: height   ?? 48.h,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: bgColor,
          gradient: !isGradientEnabled ? null : gradient ?? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withOpacity(0.7),
              AppColors.primary.withOpacity(0.7),
              AppColors.secondary.withOpacity(0.6),
              AppColors.primary.withOpacity(0.7),
            ],
            stops: [0.0, 0.1, 0.4, 1.0], // Stops for border dominance and center emphasis
          ),
            border: Border.all(color: borderColor ?? AppColors.transparent),
          borderRadius: BorderRadius.circular(borderRadius ?? 50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(icon!= null)
              icon!,
            if(icon!= null)
            6.width,
            Text(
              title,
              key: textKey,
              style: textStyle ??
                  AppTextStyles.customText18(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}