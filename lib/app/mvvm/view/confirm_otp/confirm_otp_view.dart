import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:pinput/pinput.dart';
import 'package:souq_ai/app/config/app_text_style.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import 'package:souq_ai/app/mvvm/view_model/auth_controllers/change_password_controller.dart';
import 'package:souq_ai/app/mvvm/view_model/auth_controllers/confirm_otp_controller.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_routes.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/textField.dart';

class ConfirmOtpView extends StatefulWidget {
  const ConfirmOtpView({super.key});

  @override
  State<ConfirmOtpView> createState() => _ConfirmOtpViewState();
}

class _ConfirmOtpViewState extends State<ConfirmOtpView> {

  ConfirmOtpController controller = Get.find<ConfirmOtpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.black,
      appBar: CustomAppBar(
        title: "Email",
        centerTitle: false,
        elevation: 0,
        toolBarHeight: 60.h,
        backgroundColor: Colors.transparent,

      ),

      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.bgImage),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(

            height: 1.sh,
            width: 1.sw,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Column(
                children: [
                  (130.h).height,
                  Spacer(flex: 1,),

                  Text("Verification", style: AppTextStyles.customText20(color: Colors.white, fontWeight: FontWeight.w600),),
                  Text("Please Enter the code we sent to you", style: AppTextStyles.customText12(color: Colors.white, fontWeight: FontWeight.w400),),
                  30.h.height,
                  Transform.scale(
                    scale: 1.sp,
                    child: Center(child: customPinput()),
                  ),

                  Spacer(flex: 4,),

                  CustomButton(
                    height: 60.h,
                    borderRadius: 12.sp,
                    title: "Confirm",
                    isGradientEnabled: true,
                    onPressed: () {
                      Get.toNamed(AppRoutes.membershipView);
                    },
                  ),
                  20.h.height,
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Resend",
                      style:
                      AppTextStyles.customText14(fontWeight: FontWeight.w400, color: AppColors.white,),
                    ),
                  ),
                  Spacer(flex: 1,),

                ],
              ).paddingHorizontal(18.w),
            ),
          ),
        ),
      ),
    );
  }



Widget customPinput() {
  return Pinput(
    length: 4,
    showCursor: true,

    onChanged: (value) {
      print('Pin Entered: $value');
    },
    onCompleted: (pin) {
      // controller.numberOtp = pin;
      // print('Pin complete: ${controller.numberOtp}');
    },
    defaultPinTheme: PinTheme(
      width: 55.w,
      height: 55.h,
      textStyle: AppTextStyles.customText20(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.07)),
        color: Colors.white.withOpacity(0.1), // Adjust background color here
      ),
    ),
    focusedPinTheme: PinTheme(
      width: 55.w,
      height: 55.h,
      textStyle: AppTextStyles.customText20(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.2),
        color: Colors.white.withOpacity(0.1),
      ),
    ),
    submittedPinTheme: PinTheme(
      width: 55.w,
      height: 55.h,
      textStyle: AppTextStyles.customText20(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,

        border: Border.all(color: Colors.white.withOpacity(0.07)),
        color: Colors.white.withOpacity(0.1),
      ),
    ),
    errorPinTheme: PinTheme(
      width: 55.w,
      height: 55.h,
      textStyle: AppTextStyles.customText20(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,

        border: Border.all(color: Colors.white.withOpacity(0.07)),
        color: Colors.white.withOpacity(0.1),
      ),
    ),
  );
}

}

