import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:souq_ai/app/config/app_text_style.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import 'package:souq_ai/app/widgets/custom_cached_image.dart';
import '../../config/app_assets.dart';
import '../../config/app_colors.dart';
import '../../config/global_variables.dart';
import '../../config/utils.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/loader.dart';
import '../../widgets/textField.dart';
import '../view_model/app_drawer_controller.dart';

class PersonalDetailsView extends StatefulWidget {
  const PersonalDetailsView({super.key});

  @override
  State<PersonalDetailsView> createState() => _PersonalDetailsViewState();
}

class _PersonalDetailsViewState extends State<PersonalDetailsView> {
  final AppDrawerController controller = Get.find();

  void initState() {
    // TODO: implement initState

    controller.currentUserFetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        elevation: 0.0,
        title: 'Personal Details',
        backgroundColor: Colors.transparent,
        centerTitle: false,
      ),
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(AppAssets.bgImage), fit: BoxFit.cover)),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Adjust blur intensity
            child: Obx(() {
              return controller.isUserLoading.value
                  ? CustomActivityIndicator()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          // (kToolbarHeight + 80).h.height,
                          110.h.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
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
                                  height: 98.0.h,
                                  width: 98.0.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.primary,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: controller.rXfile.value == null
                                      ? CustomCachedImage(
                                          height: 60.sp,
                                          width: 60.sp,
                                          imageUrl: controller.currentUser?.profilePic ??
                                              'https://images.pexels.com/photos/15254640/pexels-photo-15254640/free-photo-of-leather-sofas-in-house-interior-design.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                          borderRadius: 100.sp,
                                        ).paddingFromAll(4.sp)
                                      : Container(
                                          height: 89.0.h,
                                          width: 89.0.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: FileImage(controller.rXfile.value!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ).paddingFromAll(4.sp),
                                ),
                              ),
                            ],
                          ),
                          8.h.height,
                          Text('Change', style: AppTextStyles.customText12(color: AppColors.white)),
                          25.h.height,
                          CustomField(
                            controller: controller.userNameController,
                            labelTitle: '',
                            labelColor: AppColors.white,
                            labelTextFontSize: 13.sp,
                            hintText: 'Elizabeth',
                            enabledBorderColor: AppColors.white,
                            focusedBorderColor: AppColors.white,
                            fillColor: AppColors.white.withOpacity(0.05),
                            filled: true,
                          ),
                          CustomField(
                            controller: controller.userPhoneController,
                            isReadOnly: true,
                            labelTitle: '',
                            labelColor: AppColors.white,
                            labelTextFontSize: 13.sp,
                            hintText: '(603) 555-0123',
                            enabledBorderColor: AppColors.white,
                            focusedBorderColor: AppColors.white,
                            fillColor: AppColors.white.withOpacity(0.05),
                            filled: true,
                          ),
                          CustomField(
                            controller: controller.userEmailController,
                            isReadOnly: true,
                            labelTitle: '',
                            labelColor: AppColors.white,
                            labelTextFontSize: 13.sp,
                            hintText: 'elizybeth79@gmail.com',
                            enabledBorderColor: AppColors.white,
                            focusedBorderColor: AppColors.white,
                            fillColor: AppColors.white.withOpacity(0.05),
                            filled: true,
                          ),
                          50.h.height,
                          Obx(() {
                            return controller.isUserUpdateLoading.value
                                ? Center(child: CustomActivityIndicator())
                                : CustomButton(
                                    height: 60.sp,
                                    borderRadius: 10.sp,
                                    title: "Change",
                                    isGradientEnabled: true,
                                    onPressed: () async {
                                      bool isUserUpdated = await controller.updateUser();
                                      if (isUserUpdated) {
                                        CustomSnackbar.show(
                                          iconData: Icons.check_circle,
                                          title: "Update Alert",
                                          message: "",
                                          backgroundColor: AppColors.white,
                                          iconColor: Colors.green,
                                          messageTextList: ["Update Successful"],
                                          messageTextColor: Colors.black,
                                        );
                                      } else {
                                        CustomSnackbar.show(
                                          iconData: Icons.warning_amber,
                                          title: "Update Error",
                                          message: "",
                                          backgroundColor: AppColors.white,
                                          iconColor: AppColors.negativeRed,
                                          messageTextList: GlobalVariables.errorMessages,
                                          messageTextColor: Colors.black,
                                        );
                                      }
                                    },
                                  );
                          }).paddingTop(40.h).paddingLeftRight(18.w),
                        ],
                      ).paddingHorizontal(15.w),
                    );
            })),
      ),
    );
  }
}
