import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:pinput/pinput.dart';
import 'package:souq_ai/app/config/app_text_style.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import 'package:souq_ai/app/mvvm/view_model/auth_controllers/account_deletion_controller.dart';
import 'package:souq_ai/app/mvvm/view_model/auth_controllers/change_password_controller.dart';
import 'package:souq_ai/app/mvvm/view_model/auth_controllers/confirm_otp_controller.dart';
import 'package:souq_ai/app/widgets/loader.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_routes.dart';
import '../../../config/global_variables.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/textField.dart';

class AccountDeletionView extends StatefulWidget {
  const AccountDeletionView({super.key});

  @override
  State<AccountDeletionView> createState() => _AccountDeletionViewState();
}

class _AccountDeletionViewState extends State<AccountDeletionView> {
  AccountDeletionController controller = Get.find<AccountDeletionController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.black,
      appBar: CustomAppBar(
        title: "Account Deletion",
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
          child: Obx(() {
            return controller.isLoading.value
                ? Center(child: CustomActivityIndicator())
                : Container(
                    height: 1.sh,
                    width: 1.sw,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Column(
                        children: [
                          (130.h).height,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                AppAssets.dangerIcon,
                                height: 22.sp,
                                width: 22.sp,
                              ),
                              6.w.width,
                              Expanded(
                                  child: Text(
                                "Your account will be permanently deleted. You no longer can access it.",
                                style: AppTextStyles.customText12(color: Color(0xFFCF0A0A), fontWeight: FontWeight.w400),
                              )),
                            ],
                          ),
                          60.h.height,
                          Obx(() {
                            return Form(
                              key: _formKey,
                              child: CustomField(
                                controller: controller.currentPasswordController,
                                labelTitle: 'Enter your  password to continue',
                                labelColor: AppColors.white,
                                obscureText: controller.currentPasswordVisibility.value,
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
                                labelTextFontSize: 13.sp,
                                hintText: 'Current Password',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '︎ This field cannot be empty';
                                  }

                                  String? errorMessage;
                                  if (value.length < 8) {
                                    errorMessage = 'Password must be at least 8 characters long.';
                                  }
                                  if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                                    if (errorMessage == null) {
                                      errorMessage = '︎Password must contain at least one uppercase letter.';
                                    } else {
                                      errorMessage += '\n︎Password must contain at least one uppercase letter.';
                                    }
                                  }
                                  if (!RegExp(r'(?=.*[!@#$%^&*])').hasMatch(value)) {
                                    if (errorMessage == null) {
                                      errorMessage = 'Password must contain at least one special character.';
                                    } else {
                                      errorMessage += '\n︎Password must contain at least one special character.';
                                    }
                                  }
                                  if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                                    if (errorMessage == null) {
                                      errorMessage = '︎Password must contain at least one number.';
                                    } else {
                                      errorMessage += '\n︎Password must contain at least one number.';
                                    }
                                  }

                                  return errorMessage;
                                },
                                enabledBorderColor: AppColors.white,
                                focusedBorderColor: AppColors.white,
                                fillColor: AppColors.white.withOpacity(0.05),
                                textInputAction: TextInputAction.done,
                                filled: true,
                              ),
                            );
                          }),
                          Spacer(
                            flex: 4,
                          ),
                          Obx(() {
                            return controller.isDeleteLoading.value
                                ? Center(child: CustomActivityIndicator())
                                : CustomButton(
                                    height: 60.h,
                                    borderRadius: 12.sp,
                                    title: "Delete My Account",
                                    isGradientEnabled: true,
                                    onPressed: () async {
                                      bool isDeleted = await controller.deleteAccount();

                                      if (isDeleted) {

                                        Get.offAllNamed(AppRoutes.signInView);
                                        CustomSnackbar.show(
                                          iconData: Icons.check_circle,
                                          title: "Delete Alert",
                                          message: "",
                                          backgroundColor: AppColors.white,
                                          iconColor: Colors.green,
                                          messageTextList: ["Update Successful"],
                                          messageTextColor: Colors.black,
                                        );
                                      } else {
                                        // Get.back();

                                        CustomSnackbar.show(
                                          iconData: Icons.warning_amber,
                                          title: "Delete Error",
                                          message: "",
                                          backgroundColor: AppColors.white,
                                          iconColor: AppColors.negativeRed,
                                          messageTextList: GlobalVariables.errorMessages,
                                          messageTextColor: Colors.black,
                                        );
                                      }
                                    },
                                  );
                          }),
                          Spacer(
                            flex: 1,
                          ),
                        ],
                      ).paddingHorizontal(18.w),
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
