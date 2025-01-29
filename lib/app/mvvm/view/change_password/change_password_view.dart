import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:souq_ai/app/config/app_text_style.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import 'package:souq_ai/app/mvvm/view_model/auth_controllers/change_password_controller.dart';
import 'package:souq_ai/app/widgets/loader.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/global_variables.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/textField.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  ChangePasswordController controller = Get.find<ChangePasswordController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.black,
      appBar: CustomAppBar(
        title: "Change Password",
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    (130.h).height,
                    Row(
                      children: [
                        Text(
                          "Enter your current Password to proceed",
                          style: AppTextStyles.customText11(color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    25.h.height,
                    Obx(() {
                      return CustomField(
                        controller: controller.currentPasswordController,
                        titleWidget: SizedBox.shrink(),
                        labelColor: AppColors.white,
                        labelTextFontSize: 13.sp,
                        hintText: 'Current Password',
                        obscureText: controller.currentPasswordVisibility.value,
                        enabledBorderColor: AppColors.white,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          String? errorMessage;
                          // Check for minimum length of 8 characters
                          if (value.length < 8) {
                            errorMessage = 'Password must be at least 8 characters long.';
                          }
                          // Check for at least one uppercase letter
                          if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                            if (errorMessage == null) {
                              errorMessage = 'Password must contain at least one uppercase letter.';
                            } else {
                              errorMessage += '\nPassword must contain at least one uppercase letter.';
                            }
                          }
                          // Check for at least one special character
                          if (!RegExp(r'(?=.*[!@#$%^&*])').hasMatch(value)) {
                            if (errorMessage == null) {
                              errorMessage = 'Password must contain at least one special character.';
                            } else {
                              errorMessage += '\nPassword must contain at least one special character.';
                            }
                          }

                          // Check for at least one number
                          if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                            if (errorMessage == null) {
                              errorMessage = 'Password must contain at least one number.';
                            } else {
                              errorMessage += '\nPassword must contain at least one number.';
                            }
                          }

                          return errorMessage; // Return all accumulated error messages, if any
                        },
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.toggleCurrentPasswordVisibility();
                          },
                          child: Icon(
                            controller.currentPasswordVisibility.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: AppColors.white.withOpacity(0.5),
                            size: 20.sp,
                          ),
                        ),
                        focusedBorderColor: AppColors.white,
                        fillColor: AppColors.white.withOpacity(0.05),
                        filled: true,
                      );
                    }),
                    20.h.height,
                    Obx(() {
                      return CustomField(
                        controller: controller.newPasswordController,
                        // labelTitle: 'New Password',
                        titleWidget: SizedBox.shrink(),
                        labelColor: AppColors.white,
                        obscureText: controller.newPasswordVisibility.value,

                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.toggleNewPasswordVisibility();
                          },
                          child: Icon(
                            controller.newPasswordVisibility.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: AppColors.white.withOpacity(0.5),
                            size: 20.sp,
                          ),
                        ),
                        labelTextFontSize: 13.sp,
                        hintText: 'New Password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          String? errorMessage;
                          // Check for minimum length of 8 characters
                          if (value.length < 8) {
                            errorMessage = 'Password must be at least 8 characters long.';
                          }
                          // Check for at least one uppercase letter
                          if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                            if (errorMessage == null) {
                              errorMessage = 'Password must contain at least one uppercase letter.';
                            } else {
                              errorMessage += '\nPassword must contain at least one uppercase letter.';
                            }
                          }
                          // Check for at least one special character
                          if (!RegExp(r'(?=.*[!@#$%^&*])').hasMatch(value)) {
                            if (errorMessage == null) {
                              errorMessage = 'Password must contain at least one special character.';
                            } else {
                              errorMessage += '\nPassword must contain at least one special character.';
                            }
                          }

                          // Check for at least one number
                          if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                            if (errorMessage == null) {
                              errorMessage = 'Password must contain at least one number.';
                            } else {
                              errorMessage += '\nPassword must contain at least one number.';
                            }
                          }

                          return errorMessage; // Return all accumulated error messages, if any
                        },
                        enabledBorderColor: AppColors.white,
                        focusedBorderColor: AppColors.white,
                        fillColor: AppColors.white.withOpacity(0.05),
                        textInputAction: TextInputAction.done,
                        filled: true,
                      );
                    }),
                    20.h.height,
                    Obx(() {
                      return CustomField(
                        controller: controller.confirmPasswordController,
                        // labelTitle: 'Confirm Password',
                        titleWidget: SizedBox.shrink(),
                        labelColor: AppColors.white,
                        obscureText: controller.confirmPasswordVisibility.value,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          String? errorMessage;
                          // Check for minimum length of 8 characters
                          if (value.length < 8) {
                            errorMessage = 'Password must be at least 8 characters long.';
                          }
                          // Check for at least one uppercase letter
                          if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                            if (errorMessage == null) {
                              errorMessage = 'Password must contain at least one uppercase letter.';
                            } else {
                              errorMessage += '\nPassword must contain at least one uppercase letter.';
                            }
                          }
                          // Check for at least one special character
                          if (!RegExp(r'(?=.*[!@#$%^&*])').hasMatch(value)) {
                            if (errorMessage == null) {
                              errorMessage = 'Password must contain at least one special character.';
                            } else {
                              errorMessage += '\nPassword must contain at least one special character.';
                            }
                          }

                          // Check for at least one number
                          if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                            if (errorMessage == null) {
                              errorMessage = 'Password must contain at least one number.';
                            } else {
                              errorMessage += '\nPassword must contain at least one number.';
                            }
                          }

                          return errorMessage; // Return all accumulated error messages, if any
                        },
                        hintText: 'Confirm Password',
                        enabledBorderColor: AppColors.white,
                        focusedBorderColor: AppColors.white,
                        fillColor: AppColors.white.withOpacity(0.05),
                        textInputAction: TextInputAction.done,
                        filled: true,
                      );
                    }),
                    Spacer(
                      flex: 3,
                    ),
                    Obx(() {
                      return
                        controller.isChangeLoading.value?
                            CustomActivityIndicator():
                        CustomButton(
                          height: 60.h,
                          borderRadius: 12.sp,
                          title: "Save",
                          isGradientEnabled: true,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              bool? hasLogin = await controller.changePassword();
                              if (hasLogin == true) {
                                CustomSnackbar.show(
                                  iconData: Icons.check_circle,
                                  title: "Password Alert",
                                  message: "",
                                  backgroundColor: AppColors.white,
                                  iconColor: Colors.green,
                                  messageTextList: ["Password Changed Successfully"],
                                  messageTextColor: Colors.black,
                                );
                                // Get.offAllNamed(AppRoutes.navbarView);
                              } else {
                                CustomSnackbar.show(
                                  iconData: Icons.warning_amber,
                                  title: "Password Error",
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
                          });
                    }),
                    100.h.height,
                    // Spacer(
                    //   flex: 1,
                    // ),
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Text(
                    //     "Forgot password?",
                    //     style: AppTextStyles.customText14(
                    //       fontWeight: FontWeight.w400,
                    //       color: AppColors.white,
                    //     ),
                    //   ),
                    // ),
                    // Spacer(
                    //   flex: 2,
                    // ),
                  ],
                ).paddingHorizontal(18.w),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
