import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:souq_ai/app/config/app_assets.dart';
import 'package:souq_ai/app/config/app_routes.dart';

import '../view_model/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  final SplashController controller = Get.find();

  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      controller.checkUserData();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.bgImage),
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
        ),
        child: Center(
          child: Image.asset(
            AppAssets.splash,
            height: 176.w,
            width: 196.w,
          )
              .animate()
              .fadeIn(
            duration: 800.ms,
            curve: Curves.easeInOut,
          ) // Smooth fade-in
              .scale(
            duration: 1000.ms,
            curve: Curves.easeInOutBack,
          ) // Slight overshoot for a dynamic pop
              .then()
              .rotate(
            begin: -0.02,
            end: 0.0,
            duration: 500.ms,
            curve: Curves.easeOutQuad,
          ) // Adds a tiny rotation effect
              .then()
              .moveY(
            begin: -20,
            end: 0,
            duration: 600.ms,
            curve: Curves.decelerate,
          ), // Gentle drop-in effect
        ),
      ),
    );


  }
}
