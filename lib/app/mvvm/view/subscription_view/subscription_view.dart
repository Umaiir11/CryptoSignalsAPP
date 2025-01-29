import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_routes.dart';
import '../../../config/app_text_style.dart';
import '../../../widgets/blur_container.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_app_bar.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({super.key});

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  bool isPremium = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        elevation: 0.0,
        title: 'Subscription',
        backgroundColor: Colors.transparent,
        centerTitle: false,
      ),
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
              children: [
                Spacer(flex: 1,),
                Center(
                  child: BlurContainer(
                    height: 81.w,
                    borderRadius: 10.sp,
                    child: Image.asset(
                      AppAssets.crown,
                      height: 128.w,
                      width: 143.w,
                    ),
                  ).paddingTop(130.h).paddingLeftRight(147.w),
                ),
                Text(
                  "Membership",
                  style: AppTextStyles.customText20(fontWeight: FontWeight.w600, color: AppColors.white),
                ).paddingTop(30.h),
                Text(
                  isPremium ? "You have Unlimited access to all features" : "Get Unlimited access to all features",
                  style: AppTextStyles.customText14(fontWeight: FontWeight.w300, color: AppColors.white),
                ).paddingTop(7.h),
               if(!isPremium)
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
                          style: AppTextStyles.customText26(fontWeight: FontWeight.w800, color: AppColors.primary),
                        ).paddingTop(8.h),
                        Text(
                          'monthly',
                          style: AppTextStyles.customText14(fontWeight: FontWeight.w400, color: AppColors.primary),
                        ).paddingTop(1.4.h),
                        Text(
                          "Enjoy the added benefit of\ncanceling at any time.",
                          textAlign: TextAlign.center, // Aligns the whole text to the left
                          style: AppTextStyles.customText14(fontWeight: FontWeight.w400, color: AppColors.white),
                        ).paddingTop(7.5.h),
                      ],
                    )).paddingTop(33.h).paddingLeftRight(18.w),
                Spacer(flex: 2,),
                if(isPremium)
                Text(
                  "* 30 Days Left",
                  style: AppTextStyles.customText12(fontWeight: FontWeight.w500, color: AppColors.white),
                ),
                CustomButton(
                  height: 60.sp,
                  borderRadius: 10.sp,
                  title: "Upgrade",
                  textStyle: AppTextStyles.customText16(color: isPremium ? Colors.white.withOpacity(0.3) : Colors.white),
                  gradient: isPremium
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary.withOpacity(0.3),
                            AppColors.primary.withOpacity(0.3),
                            AppColors.secondary.withOpacity(0.2),
                            AppColors.primary.withOpacity(0.3),
                          ],
                          stops: [0.0, 0.1, 0.4, 1.0], // Stops for border dominance and center emphasis
                        )
                      : null,
                  isGradientEnabled: true,
                  onPressed: () {
                    setState(() {
                      isPremium = true;

                    });
                  },
                ).paddingTop(19.h).paddingLeftRight(19.w),
                20.h.height,
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isPremium = false;
                    });
                  },
                  child: Center(
                      child: Text(
                    "Want to cancel Subscription?",
                    style: AppTextStyles.customText14(
                      color: AppColors.primary.withOpacity(isPremium ? 1.0 : 0.4),
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                ),
                15.h.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
