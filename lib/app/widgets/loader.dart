import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/app_colors.dart';

Widget CustomActivityIndicator({
  Color color = AppColors.primary, // Default color
  double radius = 17.0, // Default radius
  bool animating = true, // Default animating behavior
}) {
  return CupertinoActivityIndicator(
    color: color,
    radius: radius.sp,
    animating: animating,
  );
}
