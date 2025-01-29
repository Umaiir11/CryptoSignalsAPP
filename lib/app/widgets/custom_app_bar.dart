import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import 'package:souq_ai/app/widgets/back_button.dart';
import '../config/app_colors.dart';
import '../config/app_text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double? toolBarHeight;
  final Color? backButtonColor;
  final VoidCallback? onBackPressed;
  final bool centerTitle;
  final double elevation;
  final Color backgroundColor;
  final Color shadowColor;
  final Color titleColor;
  final Widget? trailing;
  final Widget? leading;
  final bool shouldAddBG;
  final Widget? titleWidget;
  final double? leadingWidth;
  final double? titleSpacing;
  final double? titleFontSize;
  final bool shouldAddBackButton;
  final SystemUiOverlayStyle? statusBarStyle;

  const CustomAppBar({
    Key? key,
    this.title,
    this.leadingWidth,
    this.onBackPressed,
    this.centerTitle = true,
    this.elevation = 1.0,
    this.backgroundColor = AppColors.secondary,
    this.shadowColor = Colors.black,
    this.titleColor = Colors.black,
    this.trailing,
    this.leading,
    this.shouldAddBG = false,
    this.statusBarStyle,
    this.titleWidget,
    this.titleSpacing,
    this.backButtonColor,
    this.toolBarHeight,
    this.shouldAddBackButton = true,
    this.titleFontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolBarHeight ?? kToolbarHeight,
      scrolledUnderElevation: 0.0,
      systemOverlayStyle: statusBarStyle ??
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,
      leadingWidth: leadingWidth ?? 50.w,
      elevation: elevation,
      titleSpacing: titleSpacing,
      shadowColor: shadowColor.withOpacity(0.3),
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      leading: shouldAddBackButton ? (leading ?? CryptoBackButton().paddingLeft(15.w).paddingTop(10.h).paddingBottom(10.h).paddingRight(0.w)) : null,
      title: title != null
          ? Text(
              title ?? '',
              style: AppTextStyles.customText24(
                letterSpacing: -0.5,
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          : titleWidget,
      actions: [
        if (trailing != null) trailing!,
        10.w.width,
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolBarHeight ?? kToolbarHeight);
}
