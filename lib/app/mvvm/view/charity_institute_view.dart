import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import 'package:souq_ai/app/widgets/custom_cached_image.dart';
import 'package:souq_ai/app/widgets/loader.dart';
import 'package:souq_ai/app/widgets/souq_dropdown.dart';
import '../../config/app_assets.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_style.dart';
import '../../widgets/blur_container.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_snackbar.dart';
import '../view_model/zakat_controller.dart';

class CharityInstituteView extends StatefulWidget {
  const CharityInstituteView({super.key});

  @override
  State<CharityInstituteView> createState() => _CharityInstituteViewState();
}

class _CharityInstituteViewState extends State<CharityInstituteView> {

  final ZakatController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState

     controller.fetchInstitutes(1);
    controller.resetPagination();

    controller.setupScrollListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        elevation: 0.0,
        title: 'Charity Institute',
        backgroundColor: Colors.transparent,
        centerTitle: false,
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
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Adjust blur intensity
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (kToolbarHeight + 50).h.height,
                20.h.height,
                Obx(() {
                  return SouqDropdownWidget<String>(
                    items: controller.charityList,
                    selectedValue: controller.selectedCharity?.value,
                    hintText: "Charity List",
                    textStyle: AppTextStyles.customText16(color: Colors.white),
                    hintTextStyle: AppTextStyles.customText16(color: Colors.white.withOpacity(0.4)),
                    onChanged: (newValue) {
                      controller.selectedCharity?.value = newValue ?? "";
                      controller.fetchInstitutes(1);
                      controller.resetPagination();
                    },
                  );
                }).animate()
                    .fadeIn(duration: 800.ms, delay: 1200.ms)
                    .scale( duration: 1000.ms, curve: Curves.easeOutBack),
                16.h.height,
                BlurContainer(
                  borderRadius: 6.sp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name',
                        style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5)),
                      ),
                      Text(
                        'Action',
                        style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5)),
                      ),
                    ],
                  ).paddingHorizontal(15.w).paddingVertical(7.h),
                ).animate()
                    .fadeIn(duration: 500.ms, delay: 600.ms)
                    .slide(begin: Offset(-30.w, 0), duration: 500.ms, curve: Curves.easeOutCubic), //left

                Obx(() {
                  return controller.isLoading.value
                      ? Expanded(child: Center(child: CustomActivityIndicator())) :
                  Expanded(
                    child: Obx(() {
                      // Show "No institutes available" message when the list is empty
                      if (controller.institutesList.isEmpty && !controller.isLoading.value) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(30.sp),
                            child: Text(
                              "No institutes available",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.customText12(color: AppColors.white),
                            ),
                          ),
                        );
                      }

                      // Show list if data exists
                      return ListView.builder(
                        controller: controller.scrollController,
                        itemCount: controller.hasMoreData.value
                            ? controller.institutesList.length + 1 // Add loader
                            : controller.institutesList.length,
                        itemBuilder: (context, index) {
                          // Loader for "loading more data" at the bottom
                          if (index == controller.institutesList.length) {
                            return Center(
                              child: CustomActivityIndicator(),
                            );
                          }

                          // Actual institute tiles
                          final institutes = controller.institutesList[index];
                          return Animate(
                            effects: [
                              FadeEffect(
                                duration: 250.ms + (index * 100).ms,
                                curve: Curves.easeInOut,
                              ),
                              SlideEffect(
                                duration: 250.ms + (index * 100).ms,
                                curve: Curves.easeInOut,
                                begin: const Offset(0, 0.4), // More noticeable slide-up
                              ),
                              ScaleEffect(
                                duration: 250.ms + (index * 100).ms,
                                curve: Curves.easeOutBack, // Subtle bounce scale
                              ),
                            ],
                            child: _buildTileForCharity(
                              onVisitTap: () {
                                if (institutes.url != null && institutes.url.isNotEmpty) {
                                  controller.launchUrlFromAPP(institutes.url);
                                } else {
                                  CustomSnackbar.show(
                                    iconData: Icons.warning_amber,
                                    title: "URL Error",
                                    message: "The provided URL is invalid or not available.",
                                    backgroundColor: AppColors.white,
                                    iconColor: AppColors.negativeRed,
                                    messageTextList: [],
                                    messageTextColor: Colors.black,
                                  );
                                }
                              },
                              title: institutes.name,
                              imgPath: institutes.profilePic ??
                                  'https://images.pexels.com/photos/18405211/pexels-photo-18405211/free-photo-of-field-of-colorful-dahlias-under-blue-sky.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                            ),
                          );
                        },
                      );
                    }),
                  );

                }),
                80.h.height,
              ],
            )).paddingHorizontal(17.w),

      ),
    );
  }

  Widget _buildTileForCharity({required String title, double? height, String? imgPath, VoidCallback? onVisitTap}) {
    return Container(
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
            .8,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          width: 1,
        ),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  height: 40.sp,
                  width: 40.sp,
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.09),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: CustomCachedImage(height: 30.sp, width: 30.sp, imageUrl: imgPath ?? '', borderRadius: 100.sp)),
                ),
                10.w.width,
                Expanded(
                  child: Text(
                   title,
                    style: AppTextStyles.customText12(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1, // Ensures the text stays on one line
                    overflow: TextOverflow.ellipsis, // Adds ellipsis (...) for overflow
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onVisitTap,
            child: BlurContainer(
              width: 70.w,
              borderRadius: 5.sp,
              child: Center(
                child: Text(
                  'Visit',
                  style: AppTextStyles.customText12(color: AppColors.white),
                ),
              ).paddingVertical(6.h).paddingHorizontal(10.w),
            ),
          )
        ],
      ).paddingHorizontal(8.w).paddingVertical(8.h),
    ).paddingBottom(10.h);
  }
}
