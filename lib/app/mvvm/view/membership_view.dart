import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';

import '../../config/app_assets.dart';
import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../config/app_text_style.dart';
import '../../widgets/blur_container.dart';
import '../../widgets/button.dart';
import '../../widgets/textField.dart';

class MembershipView extends StatefulWidget {
  const MembershipView({super.key});

  @override
  State<MembershipView> createState() => _MembershipViewState();
}

class _MembershipViewState extends State<MembershipView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 1.sh,
          width: 1.sw,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.bgImage),
              fit: BoxFit.fill,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Adjust blur intensity
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


              Center(
                child: BlurContainer(
                height: 81.w,
                borderRadius: 10.sp,
                child: Image.asset(
                  AppAssets.crown,
                  height: 128.w,
                  width: 143.w,
                ),
                            )
                    .paddingTop(130.h).paddingLeftRight(147.w),
              ),

                Text(
                  "Membership",
                  style: AppTextStyles.customText20(fontWeight: FontWeight.w600, color: AppColors.white),
                ).paddingTop(30.h),
                Text(
                  "Get Unlimited access to all features",
                  style: AppTextStyles.customText14(fontWeight: FontWeight.w400, color: AppColors.white),
                ).paddingTop(7.h),
                BlurContainer(
                  height: 185.w,
                  borderRadius: 10.sp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Monthly Subscription",
                        style: AppTextStyles.customText14(fontWeight: FontWeight.w400, color: AppColors.white),
                      ).paddingTop(30.h),
                      Text(
                          '\$11.00',
                        style: AppTextStyles.customText26(fontWeight: FontWeight.w800, color: AppColors.warningColor),
                      ).paddingTop(8.h),
                      Text(
                        'monthly',
                        style: AppTextStyles.customText14(fontWeight: FontWeight.w400, color: AppColors.warningColor),
                      ).paddingTop(1.4.h),
                      Text(
                        "Enjoy the added benefit of\ncanceling at any time.",
                        textAlign: TextAlign.center, // Aligns the whole text to the left
                        style: AppTextStyles.customText14(fontWeight: FontWeight.w400, color: AppColors.white),
                      )

                          .paddingTop(7.5.h),
                    ],
                  )
                ).paddingTop(33.h).paddingLeftRight(18.w),


                Container(
                  height:65.h,
                  width: 338.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.secondary, // Set the border color here
                      width: 0.1, // Adjust the border width
                    ),
                    borderRadius: BorderRadius.circular(8.0), // Optional: for rounded corners
                  ),
                  child: Center(child: Text("Continue Free",style: AppTextStyles.customText14(color: AppColors.white,fontWeight: FontWeight.w500,),)),
                ).paddingTop(70.h),
                CustomButton(
                  height: 60.sp,
                  borderRadius: 10.sp,
                  title: "Submit",
                  isGradientEnabled: true,
                  onPressed: () {
                    Get.toNamed(AppRoutes.navbarView);
                  },
                ).paddingTop(19.h).paddingLeftRight(19.w),
                Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
