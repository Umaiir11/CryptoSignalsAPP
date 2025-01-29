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

class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  final AppDrawerController appDrawerController = Get.find();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        elevation: 0.0,
        title: 'Privacy Policy',
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
                "${appDrawerController.appSetting.value?.privacyPolicy}",
                style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5)),),
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
                  // Text(
                  //   'dolor sit amet consectetur. Quam bibendum sit nec egestas facilisis molestie nisi sit sed. Lobortis neque neque amet facilisis sapien velit sed id suspendisse. Sed ac porta pellentesque magna. Varius nisl aliquet mauris tempor amet in. dolor sit amet consectetur. Quam bibendum sit nec egestas facilisis molestie nisi sit sed. Lobortis neque neque amet facilisis sapien velit sed id suspendisse. Sed ac porta pellentesque magna. Varius nisl aliquet mauris tempor amet in.',
                  //   style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5)),
                  // )
                ],
              ).paddingHorizontal(15.w),
            )),
      ),
    );
  }
}
