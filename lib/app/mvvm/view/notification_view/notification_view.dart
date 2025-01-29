import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:souq_ai/app/config/app_assets.dart';
import 'package:souq_ai/app/config/app_colors.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import 'package:souq_ai/app/widgets/custom_app_bar.dart';
import 'package:souq_ai/app/widgets/notification_tile.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        elevation: 0.0,
        title: 'Notification',
        backgroundColor: Colors.transparent,
        centerTitle: false,
      ),
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppAssets.bgImage), fit: BoxFit.cover)
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Adjust blur intensity
          child: ListView.builder(
            itemCount: 7,
            itemBuilder: (context, index) {
              return NotificationTile(
                iconBgColor: Colors.brown.withOpacity(0.4),
                title: 'Hidden crypto pair',
                isColorTransparent: index == 5 ? false : true,
                time: '2:30 Am',
                date: '04/02/2024',
                message: 'New signal available, upgrade to unlock all signals.',
                iconPath: index % 2 != 0 ? AppAssets.binanceIcon :AppAssets.passwordIcon,
              );
            },
          ).paddingTop(30.h),
        ),
      ),
    );
  }
}
