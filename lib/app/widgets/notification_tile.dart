import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:souq_ai/app/config/app_colors.dart';
import 'package:souq_ai/app/config/app_text_style.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';

class NotificationTile extends StatelessWidget {
  final String? iconPath;
  final String? title;
  final String? message;
  final String? date;
  final String? time;
  final bool? isColorTransparent;
  final Color? iconBgColor;

  const NotificationTile({super.key, this.iconPath, this.title, this.message, this.date, this.time, this.iconBgColor, this.isColorTransparent});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isColorTransparent ?? true ? AppColors.transparent : Colors.redAccent.withOpacity(0.3),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            height: 50.sp,
            width: 50.sp,
            decoration: BoxDecoration(
              color: iconBgColor ?? AppColors.black.withOpacity(0.03),
              shape: BoxShape.circle,
            ),
            child: Center(child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Adjust blur intensity
                child: SvgPicture.asset(iconPath ?? ''))),
          ),
          8.w.width,
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title ?? '', style: AppTextStyles.customText16(color: AppColors.white, fontWeight: FontWeight.w400)),
              Text(message ?? '', style: AppTextStyles.customText12(color: AppColors.white.withOpacity(0.5), fontWeight: FontWeight.w400)),
            ],
          )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date ?? '', style: AppTextStyles.customText10(color: AppColors.white.withOpacity(0.5), fontWeight: FontWeight.w400)),
              Text(time ?? '', style: AppTextStyles.customText10(color: AppColors.white.withOpacity(0.5), fontWeight: FontWeight.w400)),
            ],
          ).paddingTop(8.h)
        ],
      ).paddingHorizontal(10.w).paddingVertical(5.h),
    ).paddingBottom(15.h);
  }
}