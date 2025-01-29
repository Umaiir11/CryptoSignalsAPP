import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import '../../config/app_assets.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_style.dart';
import '../../widgets/custom_app_bar.dart';
import '../view_model/app_drawer_controller.dart';

class TermsAndConditionsView extends StatefulWidget {
  const TermsAndConditionsView({super.key});

  @override
  State<TermsAndConditionsView> createState() => _TermsAndConditionsViewState();
}

class _TermsAndConditionsViewState extends State<TermsAndConditionsView> {
  final AppDrawerController appDrawerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        elevation: 0.0,
        title: 'Terms & Conditions',
        backgroundColor: Colors.transparent,
        centerTitle: false,
      ),
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(AppAssets.bgImage), fit: BoxFit.cover)),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Adjust blur intensity
            child: SingleChildScrollView(
              child: Column(
                children: [
                  (kToolbarHeight + 60).h.height,
                  Image.asset(
                    AppAssets.splash,
                    height: 160.h,
                  ),
                  20.h.height,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'Lorem Ipsum',
                  //       style: AppTextStyles.customText16(color: AppColors.white, fontWeight: FontWeight.bold),
                  //     )
                  //   ],
                  // ),
                  // 5.h.height,
                  Text(
                    "${appDrawerController.appSetting.value?.termsAndConditions}",
                    style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5)),
                  ),
                  20.h.height,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'Lorem Ipsum',
                  //       style: AppTextStyles.customText16(color: AppColors.white, fontWeight: FontWeight.bold),
                  //     )
                  //   ],
                  // ),
                  5.h.height,
                  // Text(
                  //   "${appDrawerController.appSetting.value?.termsAndConditions}",
                  //   style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5)),),
                ],
              ).paddingHorizontal(15.w),
            )),
      ),
    );
  }
}
