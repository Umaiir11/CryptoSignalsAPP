import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:souq_ai/app/config/app_assets.dart';
import 'package:souq_ai/app/config/app_routes.dart';
import 'package:souq_ai/app/config/app_text_style.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import 'package:souq_ai/app/config/utils.dart';
import 'package:souq_ai/app/mvvm/view_model/auth_controllers/sign_in_controller.dart';
import 'package:souq_ai/app/widgets/loader.dart';
import '../../config/app_colors.dart';
import '../../config/global_variables.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/textField.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final SignInController controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Splash Image with Bounce-In Animation
                  Image.asset(
                    AppAssets.splash,
                    height: 128.w,
                    width: 143.w,
                  )
                      .paddingTop(80.h)
                      .animate()
                      .fadeIn(duration: 800.ms, curve: Curves.easeInOut)
                      .scale(begin: Offset(0.8, 0.8), end: Offset(1.0, 1.0), duration: 1000.ms, curve: Curves.easeOutBack), // Bounce effect

                  // "Welcome" Text with Delayed Slide & Scale Animation
                  Text(
                    "Welcome",
                    style: AppTextStyles.customText32(
                      fontWeight: FontWeight.w600, // Premium, bold look
                      color: AppColors.white.withOpacity(0.9), // Softer white
                    ),
                  )
                      .paddingTop(30.h)
                      .animate()
                      .slide(begin: Offset(0, -30.h), duration: 500.ms, curve: Curves.easeOutCubic) // Slide down effect
                      .fadeIn(duration: 600.ms, delay: 200.ms) // Delayed fade-in
                      .scale( duration: 750.ms, curve: Curves.easeOutExpo), // Subtle scale

                  // Subtitle Text with Staggered Opacity
                  Text(
                    "Sign in to your account",
                    style: AppTextStyles.customText14(
                      fontWeight: FontWeight.w400,
                      color: AppColors.white.withOpacity(0.7), // Slightly lighter text
                    ),
                  )
                      .paddingTop(3.h)
                      .animate()
                      .fadeIn(duration: 700.ms, delay: 400.ms), // Staggered opacity effect

                  20.h.height,

                  // Input Fields with Smooth Staggered Appearances
                  CustomField(
                    controller: controller.phoneNumberController,
                    labelTitle: 'Mobile Number',
                    prefixIcon: SvgPicture.asset(AppAssets.phoneIcon).paddingFromAll(15.sp),
                    labelColor: AppColors.white,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        controller.phoneNumberController.clear();
                      },
                      child: Icon(
                        Icons.close,
                        color: AppColors.white.withOpacity(0.5),
                        size: 20.sp,
                      ),
                    ),
                    labelTextFontSize: 13.sp,
                    hintText: 'Enter Phone Number',
                    keyboardType: TextInputType.phone,
                    enabledBorderColor: AppColors.white,
                    focusedBorderColor: AppColors.white,
                    fillColor: AppColors.white.withOpacity(0.05),
                    filled: true,
                  )
                      .paddingLeftRight(18.w)
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 600.ms)
                      .slide(begin: Offset(-30.w, 0), duration: 500.ms, curve: Curves.easeOutCubic), // Slide from left

                  20.h.height,

                  Obx(() {
                    return CustomField(
                      controller: controller.passwordController,
                      labelTitle: 'Password',
                      prefixIcon: SvgPicture.asset(AppAssets.passwordIcon).paddingFromAll(15.sp),
                      labelColor: AppColors.white,
                      obscureText: controller.obscureText.value,
                      textInputAction: TextInputAction.done,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.changeObscureText();
                        },
                        child: Icon(
                          controller.obscureText.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: AppColors.white.withOpacity(0.5),
                          size: 20.sp,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        String? errorMessage;
                        if (value.length < 8) {
                          errorMessage = 'Password must be at least 8 characters long.';
                        }
                        if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                          errorMessage = (errorMessage ?? '') + '\nPassword must contain at least one uppercase letter.';
                        }
                        if (!RegExp(r'(?=.*[!@#$%^&*])').hasMatch(value)) {
                          errorMessage = (errorMessage ?? '') + '\nPassword must contain at least one special character.';
                        }
                        if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                          errorMessage = (errorMessage ?? '') + '\nPassword must contain at least one number.';
                        }
                        return errorMessage;
                      },
                      labelTextFontSize: 13.sp,
                      hintText: 'Enter Your Password',
                      enabledBorderColor: AppColors.white,
                      focusedBorderColor: AppColors.white,
                      fillColor: AppColors.white.withOpacity(0.05),
                      filled: true,
                    );
                  })
                      .paddingLeftRight(18.w)
                      .animate()
                      .fadeIn(duration: 500.ms, delay: 800.ms)
                      .slide(begin: Offset(30.w, 0), duration: 500.ms, curve: Curves.easeOutCubic), // Slide from right

                  20.h.height,

                  // Sign-In Button with Bounce and Glow Effect
                  Obx(() {
                    return
                      controller.isSignInLoading.value?
                      Center(child: CustomActivityIndicator()):
                      CustomButton(
                        height: 60.sp,
                        borderRadius: 10.sp,
                        title: "Sign In",
                        isGradientEnabled: true,
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          // Validate form fields
                          if (_formKey.currentState!.validate()) {
                            bool hasLogin = await controller.login();
                            if (hasLogin) {
                              CustomSnackbar.show(
                                iconData: Icons.check_circle,
                                title: "Login Alert",
                                message: "",
                                backgroundColor: AppColors.white,
                                iconColor: Colors.green,
                                messageTextList: ["Login Successful"],
                                messageTextColor: Colors.black,
                              );
                              Get.offAllNamed(AppRoutes.navbarView);
                            } else {
                              CustomSnackbar.show(
                                iconData: Icons.warning_amber,
                                title: "Login Error",
                                message: "",
                                backgroundColor: AppColors.white,
                                iconColor: AppColors.negativeRed,
                                messageTextList: GlobalVariables.errorMessages,
                                messageTextColor: Colors.black,
                              );
                            }
                          } else {
                            controller.fieldsValidate = true;
                          }
                        },

                      ) .animate()
                          .fadeIn(duration: 800.ms, delay: 1200.ms)
                          .scale( duration: 1000.ms, curve: Curves.easeOutBack);
                  }).paddingTop(40.h).paddingLeftRight(18.h),
                  // Footer with Slide-Up Animation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account? ",
                        style: AppTextStyles.customText14(
                          fontWeight: FontWeight.w400,
                          color: AppColors.white.withOpacity(0.4),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.signUpView);
                        },
                        child: Text(
                          "Sign up",
                          style: AppTextStyles.customText16(
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                          ),
                        ).paddingOnly(left: 4.w),
                      ),
                    ],
                  )
                      .paddingTop(30.h)
                      .paddingLeftRight(18.w)
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 1200.ms)
                      .slide(begin: Offset(0, 30.h), duration: 500.ms, curve: Curves.easeOutCubic), // Slide up effect
                ],
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .then(delay: 200.ms)
                  .scale(duration: 300.ms, curve: Curves.fastLinearToSlowEaseIn),

            ),
          ),
        ),
      ),
    );
  }
}
