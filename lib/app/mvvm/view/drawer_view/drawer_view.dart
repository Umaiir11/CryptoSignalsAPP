import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:souq_ai/app/config/app_assets.dart';
import 'package:souq_ai/app/config/app_routes.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import 'package:souq_ai/app/mvvm/view_model/app_drawer_controller.dart';
import 'package:souq_ai/app/services/shared_preferences_helper.dart';
import 'package:souq_ai/app/widgets/custom_app_bar.dart';
import 'package:souq_ai/app/widgets/loader.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_text_style.dart';

class AppDrawerView extends StatefulWidget {
  const AppDrawerView({super.key});

  @override
  State<AppDrawerView> createState() => _AppDrawerViewState();
}

class _AppDrawerViewState extends State<AppDrawerView> {
  final AppDrawerController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fetchAppSettingsApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Obx(() {
          // return controller.isSettingsLoading.value
          //     ? Center(child: CustomActivityIndicator())
          //     :

        return  SingleChildScrollView(
                  child: Skeletonizer(

                    justifyMultiLineText: false,
                    effect: ShimmerEffect(
                      baseColor: AppColors.darkGrey,
                      highlightColor: AppColors.white, // Use ! to assert non-null
                      duration: Duration(seconds:1 ),
                    ),
                    enabled: controller.isSettingsLoading.value,
                    child: Column(
                      children: [
                        100.h.height,
                        Row(
                          children: [
                            SvgPicture.asset(AppAssets.personIcon),
                            10.w.width,
                            Text(
                              "Account",
                              style: AppTextStyles.customTextInter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                        20.h.height,
                        _buildTileForDrawer(
                            onTap: () {
                              Get.toNamed(AppRoutes.personalDetailsView);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Personal Details', style: AppTextStyles.customTextInter(fontSize: 16.sp, color: AppColors.white)),
                                Icon(Icons.arrow_forward_ios_rounded, size: 20.sp, color: AppColors.white),
                              ],
                            )),
                        15.h.height,
                        _buildTileForDrawer(
                            onTap: () {
                              Get.toNamed(AppRoutes.changePasswordView);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Change Password', style: AppTextStyles.customTextInter(fontSize: 16.sp, color: AppColors.white)),
                                Icon(Icons.arrow_forward_ios_rounded, size: 20.sp, color: AppColors.white),
                              ],
                            )),
                        15.h.height,
                        _buildTileForDrawer(
                            onTap: () {
                              Get.toNamed(AppRoutes.subscriptionView);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Subscription', style: AppTextStyles.customTextInter(fontSize: 16.sp, color: AppColors.white)),
                                Icon(Icons.arrow_forward_ios_rounded, size: 20.sp, color: AppColors.white),
                              ],
                            )),
                        30.h.height,
                        Row(
                          children: [
                            SvgPicture.asset(AppAssets.settingsIcon),
                            10.w.width,
                            Text(
                              "Settings",
                              style: AppTextStyles.customTextInter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                        15.h.height,
                        _buildTileForDrawer(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Push Notification', style: AppTextStyles.customTextInter(fontSize: 16.sp, color: AppColors.white)),
                            SizedBox(
                              height: 10.h,
                              child: Transform.scale(
                                scale: 0.8,
                                child: Obx(() {
                                  return CupertinoSwitch(
                                      trackOutlineWidth: MaterialStateProperty.all(1),
                                      trackOutlineColor: MaterialStateProperty.all(
                                        AppColors.white.withOpacity(0.25),
                                      ),
                                      activeColor: AppColors.primary,
                                      value: controller.notificationsValue.value,
                                      onChanged: (val) {
                                        controller.changeNotificationValue(val);
                                      });
                                }),
                              ),
                            ),
                          ],
                        )),
                        15.h.height,
                        _buildTileForDrawer(
                            onTap: () {
                              Get.toNamed(AppRoutes.accountDeletionView);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Account Deletion', style: AppTextStyles.customTextInter(fontSize: 16.sp, color: AppColors.white)),
                                Icon(Icons.arrow_forward_ios_rounded, size: 20.sp, color: AppColors.white),
                              ],
                            )),
                        30.h.height,
                        Row(
                          children: [
                            SvgPicture.asset(AppAssets.assistantIcon),
                            10.w.width,
                            Text(
                              "Support",
                              style: AppTextStyles.customTextInter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                        15.h.height,
                        _buildTileForDrawer(
                            onTap: () {
                              Get.toNamed(AppRoutes.aboutUsView);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('About Us', style: AppTextStyles.customTextInter(fontSize: 16.sp, color: AppColors.white)),
                                Icon(Icons.arrow_forward_ios_rounded, size: 20.sp, color: AppColors.white),
                              ],
                            )),
                        15.h.height,
                        _buildTileForDrawer(
                            onTap: () {
                              Get.toNamed(AppRoutes.privacyPolicyView);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Privacy Policy', style: AppTextStyles.customTextInter(fontSize: 16.sp, color: AppColors.white)),
                                Icon(Icons.arrow_forward_ios_rounded, size: 20.sp, color: AppColors.white),
                              ],
                            )),
                        15.h.height,
                        _buildTileForDrawer(
                            onTap: () {
                              Get.toNamed(AppRoutes.termsAndConditionsView);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Terms & Conditions', style: AppTextStyles.customTextInter(fontSize: 16.sp, color: AppColors.white)),
                                Icon(Icons.arrow_forward_ios_rounded, size: 20.sp, color: AppColors.white),
                              ],
                            )),
                        30.h.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Others",
                              style: AppTextStyles.customTextInter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                        15.h.height,
                        _buildTileForDrawer(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Share', style: AppTextStyles.customTextInter(fontSize: 16.sp, color: AppColors.white)),
                            SvgPicture.asset(AppAssets.shareIcon),
                          ],
                        )),
                        15.h.height,
                        _buildTileForDrawer(
                            onTap: () async {
                              await SharedPreferencesService().clearAllPreferences();
                              Get.offAllNamed(AppRoutes.signInView);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Sign Out', style: AppTextStyles.customTextInter(fontSize: 16.sp, color: AppColors.white)),
                                SvgPicture.asset(AppAssets.signOutIcon),
                              ],
                            )),
                        30.h.height,
                      ],
                    ).paddingLeft(70.w).paddingRight(20.w),
                  ),
                );
        }),
      ),
    );
  }

  Widget _buildTileForDrawer({required Widget child, double? height, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.black,
          gradient: LinearGradient(
            colors: [
              AppColors.white.withOpacity(.1),
              AppColors.white.withOpacity(0.06),
              AppColors.white.withOpacity(0.1),
            ],
            stops: [0.1, 0.6, 0.95],
            end: Alignment.bottomRight,
            begin: Alignment.topLeft,
          ),
          borderRadius: BorderRadius.circular(10.sp),
          border: GradientBoxBorder(
            gradient: LinearGradient(colors: [
              AppColors.white.withOpacity(.2),
              AppColors.white.withOpacity(.02),
            ], stops: [
              .3,
              .8
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            width: 1,
          ),
        ),
        child: child.paddingHorizontal(15.w).paddingVertical(15.h),
      ),
    );
  }
}
