import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:souq_ai/app/config/app_assets.dart';
import 'package:souq_ai/app/config/app_text_style.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import 'package:souq_ai/app/config/utils.dart';
import 'package:souq_ai/app/mvvm/view_model/auth_controllers/sign_up_controller.dart';
import 'package:souq_ai/app/widgets/loader.dart';
import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../config/global_variables.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/textField.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final SignUpController controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool? isChecked = false;
    return Scaffold(
      body: Container(
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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  80.h.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 98.0.h,
                            width: 98.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.secondary,
                                width: 2.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(4.sp),
                              child: Obx(() {
                                return Container(
                                  height: 89.0.h,
                                  width: 89.0.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: controller.rXfile.value == null
                                          ? AssetImage(AppAssets.userPlaceHolder) // Placeholder image
                                          : FileImage(controller.rXfile.value!), // File image
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            left: 0,
                            bottom: -11,
                            child: GestureDetector(
                              onTap: () {
                                Utils.showPickImageOptionsDialog(
                                  context,
                                  onCameraTap: () async {
                                    Navigator.of(context).pop();
                                    await controller.pickImageFromCamera();
                                  },
                                  onGalleryTap: () async {
                                    Navigator.of(context).pop();
                                    await controller.pickImageFromGallery();
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(child: Icon(Icons.add, color: AppColors.primary, size: 20.sp).paddingFromAll(3.sp)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).animate()
                      .fadeIn(duration: 800.ms, curve: Curves.easeInOut)
                      .scale(begin: Offset(0.8, 0.8), end: Offset(1.0, 1.0), duration: 1000.ms, curve: Curves.easeOutBack), // Bounce effect;,
                  // Utils.buildValidationWarning(controller.isNameValid, "Name is not Valid").paddingLeftRight(18.w).paddingTop(16.h),

                  CustomField(
                    controller: controller.fullNameController,
                    labelTitle: 'Full Name',
                    prefixIcon: SvgPicture.asset(AppAssets.personIcon).paddingFromAll(15.sp),
                    labelColor: AppColors.white,
                    labelTextFontSize: 13.sp,
                    hintText: 'Enter Full Name',
                    enabledBorderColor: AppColors.white,
                    focusedBorderColor: AppColors.white,
                    fillColor: AppColors.white.withOpacity(0.05),
                    filled: true,
                  ).paddingLeftRight(18.w).paddingTop(7.h)
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 600.ms)
                  .slide(begin: Offset(-30.w, 0), duration: 500.ms, curve: Curves.easeOutCubic), // Slide from left
                  // Utils.buildValidationWarning(controller.isEmailValid, "Email Address not Valid").paddingLeftRight(18.w).paddingTop(10.h),

                  CustomField(
                    controller: controller.emailController,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: AppColors.white,
                      size: 25.sp,
                    ),
                    labelTitle: 'Email Address',
                    labelColor: AppColors.white,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '︎This field cannot be empty';
                      }

                      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }

                      return null;
                    },
                    labelTextFontSize: 13.sp,
                    hintText: 'Enter Email Address',
                    enabledBorderColor: AppColors.white,
                    focusedBorderColor: AppColors.white,
                    fillColor: AppColors.white.withOpacity(0.05),
                    filled: true,
                  ).paddingLeftRight(18.w).paddingTop(10.h)

                      .animate()
                      .fadeIn(duration: 500.ms, delay: 800.ms)
                      .slide(begin: Offset(30.w, 0), duration: 500.ms, curve: Curves.easeOutCubic), // Slide from right,
                  // Utils.buildValidationWarning(controller.isPhoneValid, "Phone Number not Valid").paddingLeftRight(18.w).paddingTop(10.h),

                  CustomField(
                    controller: controller.phoneNumberController,
                    prefixIcon: SvgPicture.asset(AppAssets.phoneIcon).paddingFromAll(15.sp),
                    labelTitle: 'Mobile Number',
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return '︎ This field cannot be empty';
                    //   }
                    //
                    //   String? errorMessage;
                    //
                    //   // Check for minimum length (e.g., 10 digits for a phone number)
                    //   if (value.length < 10) {
                    //     errorMessage = '︎ Phone number must be at least 10 digits long.';
                    //   }
                    //
                    //   // Check if the value contains only digits
                    //   if (!RegExp(r'^\d+$').hasMatch(value)) {
                    //     if (errorMessage == null) {
                    //       errorMessage = '︎ Phone number must contain only numbers.';
                    //     } else {
                    //       errorMessage += '\n︎ Phone number must contain only numbers.';
                    //     }
                    //   }
                    //
                    //   // Optionally, check for a specific phone number format (e.g., country code + number)
                    //   if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
                    //     if (errorMessage == null) {
                    //       errorMessage = '︎ Please enter a valid phone number format.';
                    //     } else {
                    //       errorMessage += '\n︎ Please enter a valid phone number format.';
                    //     }
                    //   }
                    //
                    //   return errorMessage; // Return all accumulated error messages, if any
                    // },
                    labelColor: AppColors.white,
                    labelTextFontSize: 13.sp,
                    hintText: 'Enter Phone Number',
                    enabledBorderColor: AppColors.white,
                    focusedBorderColor: AppColors.white,
                    fillColor: AppColors.white.withOpacity(0.05),
                    filled: true,
                  ).paddingLeftRight(18.w).paddingTop(10.h) .animate()
                      .fadeIn(duration: 500.ms, delay: 600.ms)
                      .slide(begin: Offset(-30.w, 0), duration: 500.ms, curve: Curves.easeOutCubic), //left
                  // Utils.buildValidationWarning(controller.isPasswordValid, "Password not same").paddingLeftRight(18.w).paddingTop(10.h),
                  Obx(() {
                    return CustomField(
                      controller: controller.passwordController,
                      prefixIcon: SvgPicture.asset(AppAssets.passwordIcon).paddingFromAll(15.sp),
                      labelTitle: 'Password',
                      labelColor: AppColors.white,
                      labelTextFontSize: 13.sp,
                      hintText: '•••••••••••',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '︎ This field cannot be empty';
                        }

                        String? errorMessage;

                        // Check for minimum length of 8 characters
                        if (value.length < 8) {
                          errorMessage = 'Password must be at least 8 characters long.';
                        }

                        // Check for at least one uppercase letter
                        if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                          if (errorMessage == null) {
                            errorMessage = '︎Password must contain at least one uppercase letter.';
                          } else {
                            errorMessage += '\n︎Password must contain at least one uppercase letter.';
                          }
                        }

                        // Check for at least one special character
                        if (!RegExp(r'(?=.*[!@#$%^&*])').hasMatch(value)) {
                          if (errorMessage == null) {
                            errorMessage = 'Password must contain at least one special character.';
                          } else {
                            errorMessage += '\n︎Password must contain at least one special character.';
                          }
                        }

                        // Check for at least one number
                        if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                          if (errorMessage == null) {
                            errorMessage = '︎Password must contain at least one number.';
                          } else {
                            errorMessage += '\n︎Password must contain at least one number.';
                          }
                        }

                        return errorMessage; // Return all accumulated error messages, if any
                      },
                      obscureText: controller.passwordVisibility.value,
                      enabledBorderColor: AppColors.white,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.togglePasswordVisibility();
                        },
                        child: Icon(
                          controller.passwordVisibility.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: AppColors.white.withOpacity(0.5),
                          size: 20.sp,
                        ),
                      ),
                      focusedBorderColor: AppColors.white,
                      fillColor: AppColors.white.withOpacity(0.05),
                      filled: true,
                    );
                  }).paddingLeftRight(18.w).paddingTop(10.h)

                      .animate()
                      .fadeIn(duration: 500.ms, delay: 800.ms)
                      .slide(begin: Offset(30.w, 0), duration: 500.ms, curve: Curves.easeOutCubic), // Slide from right,

                  Obx(() {
                    return CustomField(
                      controller: controller.confirmPasswordController,
                      prefixIcon: SvgPicture.asset(AppAssets.passwordIcon).paddingFromAll(15.sp),
                      labelTitle: 'Confirm Password',
                      labelColor: AppColors.white,
                      obscureText: controller.confirmPasswordVisibility.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '︎This field cannot be empty';
                        }

                        String? errorMessage;

                        // Check for minimum length of 8 characters
                        if (value.length < 8) {
                          errorMessage = '︎Password must be at least 8 characters long.';
                        }

                        // Check for at least one uppercase letter
                        if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                          if (errorMessage == null) {
                            errorMessage = '︎Password must contain at least one uppercase letter.';
                          } else {
                            errorMessage += '\n︎ Password must contain at least one uppercase letter.';
                          }
                        }

                        // Check for at least one special character
                        if (!RegExp(r'(?=.*[!@#$%^&*])').hasMatch(value)) {
                          if (errorMessage == null) {
                            errorMessage = '︎Password must contain at least one special character.';
                          } else {
                            errorMessage += '\n︎Password must contain at least one special character.';
                          }
                        }

                        // Check for at least one number
                        if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                          if (errorMessage == null) {
                            errorMessage = 'Password must contain at least one number.';
                          } else {
                            errorMessage += '\n︎ Password must contain at least one number.';
                          }
                        }

                        return errorMessage; // Return all accumulated error messages, if any
                      },
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.toggleConfirmPasswordVisibility();
                        },
                        child: Icon(
                          controller.confirmPasswordVisibility.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: AppColors.white.withOpacity(0.5),
                          size: 20.sp,
                        ),
                      ),
                      labelTextFontSize: 13.sp,
                      hintText: '•••••••••••',
                      enabledBorderColor: AppColors.white,
                      focusedBorderColor: AppColors.white,
                      fillColor: AppColors.white.withOpacity(0.05),
                      textInputAction: TextInputAction.done,
                      filled: true,
                    );
                  }).paddingLeftRight(18.w).paddingTop(10.h).animate()
                      .fadeIn(duration: 500.ms, delay: 600.ms)
                      .slide(begin: Offset(-30.w, 0), duration: 500.ms, curve: Curves.easeOutCubic), //left,
                  10.h.height,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25.h,
                        width: 11.w,
                        child: Obx(() {
                          return Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.sp)),
                              value: controller.termAndConditions.value,
                              checkColor: AppColors.white,
                              activeColor: AppColors.primary,
                              side: BorderSide(color: Colors.white),
                              onChanged: (val) {
                                controller.toggleTermsAndConditions(val!);
                              },
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Flexible(
                        child: Text.rich(
                          TextSpan(text: "By signing up, you AGREE TO our ", children: [
                            TextSpan(
                              text: "Terms of Service",
                              style: AppTextStyles.customText14(fontWeight: FontWeight.w400, color: AppColors.white),
                            ),
                            TextSpan(
                              text: " & ",
                              style: AppTextStyles.customText14(fontWeight: FontWeight.w400, color: AppColors.white.withOpacity(0.4)),
                            ),
                            TextSpan(
                              text: "Privacy Policy",
                              style: AppTextStyles.customText14(fontWeight: FontWeight.w400, color: AppColors.white),
                            ),
                          ]),
                          overflow: TextOverflow.visible,
                          style: AppTextStyles.customText14(fontWeight: FontWeight.w400, color: AppColors.white.withOpacity(0.4)),
                        ),
                      ),
                    ],
                  ).paddingTop(7.h).paddingOnly(left: 30.w, right: 30.w)
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 800.ms)
                  .slide(begin: Offset(30.w, 0), duration: 500.ms, curve: Curves.easeOutCubic), // Slide from right,
                  Obx(() {
                    return controller.isSignUpLoading.value
                        ? Center(child: CustomActivityIndicator())
                        : CustomButton(
                            height: 60.sp,
                            borderRadius: 10.sp,
                            title: "Sign Up",
                            isGradientEnabled: true,
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              // Validate form fields
                              if (_formKey.currentState!.validate()) {
                                bool isPasswordMatched = controller.passwordController.text == controller.confirmPasswordController.text;
                                bool isImageUploaded = controller.rXfile.value != null && controller.rXfile.value!.path.isNotEmpty;
                                bool isTermsChecked = controller.termAndConditions.value;

                                if (!isPasswordMatched) {
                                  CustomSnackbar.show(
                                    iconData: Icons.warning_amber,
                                    title: "Password Mismatch",
                                    message: "",
                                    backgroundColor: AppColors.white,
                                    iconColor: AppColors.negativeRed,
                                    messageTextList: ["The passwords you entered do not match. Please try again."],
                                    messageTextColor: Colors.black,
                                  );
                                } else if (!isImageUploaded) {
                                  CustomSnackbar.show(
                                    iconData: Icons.warning_amber,
                                    title: "Image Required",
                                    message: "",
                                    backgroundColor: AppColors.white,
                                    iconColor: AppColors.negativeRed,
                                    messageTextList: ["Please upload an image"],
                                    messageTextColor: Colors.black,
                                  );
                                } else if (!isTermsChecked) {
                                  CustomSnackbar.show(
                                    iconData: Icons.warning_amber,
                                    title: "Terms and Conditions",
                                    message: "",
                                    backgroundColor: AppColors.white,
                                    iconColor: AppColors.negativeRed,
                                    messageTextList: ["Please accept the terms and conditions before signing up"],
                                    messageTextColor: Colors.black,
                                  );
                                } else {
                                  // Proceed with signup if all conditions are met
                                  bool hasSignup = await controller.signUp();

                                  if (hasSignup) {
                                    Get.offAndToNamed(AppRoutes.signInView);
                                    CustomSnackbar.show(
                                      iconData: Icons.check_circle,
                                      title: "Signup Alert",
                                      message: "",
                                      backgroundColor: AppColors.white,
                                      iconColor: Colors.green,
                                      messageTextList: ["Signup Successful"],
                                      messageTextColor: Colors.black,
                                    );
                                  } else {
                                    CustomSnackbar.show(
                                      iconData: Icons.warning_amber,
                                      title: "Signup Error",
                                      message: "",
                                      backgroundColor: AppColors.white,
                                      iconColor: AppColors.negativeRed,
                                      messageTextList: GlobalVariables.errorMessages,
                                      messageTextColor: Colors.black,
                                    );
                                  }
                                }
                              } else {
                                controller.fieldsValidate = true;
                              }
                            },
                          );
                  }).paddingTop(40.h).paddingLeftRight(18.w).animate()
                      .fadeIn(duration: 800.ms, delay: 1200.ms)
                      .scale( duration: 1000.ms, curve: Curves.easeOutBack),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: AppTextStyles.customText14(fontWeight: FontWeight.w400, color: AppColors.white.withOpacity(0.4)),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.offAndToNamed(AppRoutes.signInView);
                        },
                        child: Text(
                          "Sign in",
                          style: AppTextStyles.customText16(fontWeight: FontWeight.w400, color: AppColors.white),
                        ).paddingOnly(left: 4.w),
                      ),
                    ],
                  ).paddingTop(10.h).paddingLeftRight(18.w).animate()
                      .fadeIn(duration: 500.ms, delay: 600.ms)
                      .slide(begin: Offset(-30.w, 0), duration: 500.ms, curve: Curves.easeOutCubic), //left,
                  20.h.height,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}