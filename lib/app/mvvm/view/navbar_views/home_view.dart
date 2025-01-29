import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gradient_slider/gradient_slider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:souq_ai/app/config/app_routes.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import 'package:souq_ai/app/mvvm/view_model/home_controller.dart';
import 'package:souq_ai/app/widgets/loader.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_text_style.dart';
import '../../../widgets/blur_container.dart';
import '../../../widgets/cached_image.dart';
import '../../../widgets/charts/home_chart.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fetchApis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchApis();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
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
              child:  Obx(() {
                return Skeletonizer(

                  justifyMultiLineText: false,
                  enabled: controller.isApisLoading.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome Section
                      Animate(
                        effects: [
                          SlideEffect(
                            duration: 500.ms,
                            curve: Curves.easeOutBack,
                            begin: Offset(-1, 0),
                            end: Offset.zero,
                          ),
                          FadeEffect(
                            duration: 500.ms,
                            curve: Curves.easeInOut,
                          ),
                          ScaleEffect(
                            duration: 500.ms,
                            curve: Curves.easeOutBack,
                            begin: Offset(0.8, 0.8),
                            end: Offset(1, 1),
                          ),
                        ],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CachedImage(
                                  height: 50.sp,
                                  width: 50.sp,
                                  imageUrl: controller.userData?.profilePic ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYP-KKtRJXm9qK7k2_PA1utxbxWdpzGIdulQ&s",
                                  borderRadius: 100.sp,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome",
                                      style: AppTextStyles.customText18(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.white,
                                        height: 1,
                                      ),
                                    ),
                                    Text(
                                      "${controller.userData?.name}",
                                      style: AppTextStyles.customText24(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                ).paddingOnly(left: 10.w).paddingTop(10.h),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.notificationView);
                                  },
                                  child: SvgPicture.asset(AppAssets.notificationIcon),
                                ),
                                6.w.width,
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.drawerView);
                                  },
                                  child: SvgPicture.asset(AppAssets.drawerIcon),
                                ),
                              ],
                            ),
                          ],
                        ).paddingTop(40.h),
                      ),

                      // Signal Profit Rate Section
                      Animate(
                        effects: [
                          SlideEffect(
                            duration: 500.ms,
                            curve: Curves.easeOutBack,
                            begin: Offset(-1, 0),
                            end: Offset.zero,
                          ),
                          FadeEffect(
                            duration: 500.ms,
                            curve: Curves.easeInOut,
                          ),
                        ],
                        child: Text(
                          "Signal Profit Rate:",
                          style: AppTextStyles.customText16(
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ).paddingTop(28.h),
                      ),

                      // Profit Tiles Section
                      Animate(
                        effects: [
                          SlideEffect(
                            duration: 500.ms,
                            curve: Curves.easeOutBack,
                            begin: Offset(-1, 0),
                            end: Offset.zero,
                          ),
                          FadeEffect(
                            duration: 500.ms,
                            curve: Curves.easeInOut,
                          ),
                        ],
                        child: SizedBox(
                          height: 88.h,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            // Disable scrolling
                            itemCount: 3,
                            // Number of items to display
                            itemBuilder: (context, index) {
                              final profitData = controller.profitPercentages.value;

                              // Get the percentage value based on index and format it
                              String percentageText;
                              if (profitData != null) {
                                double? percentageValue;
                                switch (index) {
                                  case 0:
                                    percentageValue = profitData.sevenDays?.toDouble();
                                    break;
                                  case 1:
                                    percentageValue = profitData.fourteenDays?.toDouble();
                                    break;
                                  case 2:
                                    percentageValue = profitData.thirtyDays?.toDouble();
                                    break;
                                  default:
                                    percentageValue = 0.0;
                                }
                                percentageText = percentageValue == 0
                                    ? "0%" // Show "0%" directly for zero values
                                    : percentageValue!.toStringAsFixed(2).padLeft(7, '0') + "%";
                              } else {
                                percentageText = "N/A"; // Default when data is not loaded
                              }

                              // Render each tile
                              return BlurContainer(
                                height: 58.h,
                                width: 101.w,
                                borderRadius: 10.sp,
                                child: SizedBox(
                                  height: 58.h,
                                  width: 101.w,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        index == 0
                                            ? "7 Days:"
                                            : index == 1
                                            ? "14 Days:"
                                            : "30 Days:",
                                        style: AppTextStyles.customText12(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.white.withOpacity(0.4),
                                        ),
                                      ),
                                      Text(
                                        percentageText,
                                        style: AppTextStyles.customText12(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ],
                                  ).paddingLeft(15.w).paddingTop(9.h),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 16.w);
                            },
                          ).paddingTop(14.h),
                        ),
                      ),

                      // Portfolio Summary Section
                      Animate(
                        effects: [
                          SlideEffect(
                            duration: 500.ms,
                            curve: Curves.easeOutBack,
                            begin: Offset(-1, 0),
                            end: Offset.zero,
                          ),
                          FadeEffect(
                            duration: 500.ms,
                            curve: Curves.easeInOut,
                          ),
                        ],
                        child: Text(
                          "Portfolio Summary",
                          style: AppTextStyles.customText16(
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ).paddingTop(20.h),
                      ),

                      // Portfolio Tiles Section
                      Animate(
                        effects: [
                          SlideEffect(
                            duration: 500.ms,
                            curve: Curves.easeOutBack,
                            begin: Offset(-1, 0),
                            end: Offset.zero,
                          ),
                          FadeEffect(
                            duration: 500.ms,
                            curve: Curves.easeInOut,
                          ),
                        ],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: BlurContainer(
                                height: 170.h,
                                borderRadius: 10.sp,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "USD",
                                      style: AppTextStyles.customText28(
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    Text(
                                      controller.currentPortfolioTotal.value.toString().length > 5
                                          ? controller.currentPortfolioTotal.value.toString().substring(0, 5)
                                          : controller.currentPortfolioTotal.value.toString(),
                                      style: AppTextStyles.customText28(
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.positiveGreen,
                                            shape: BoxShape.circle,
                                          ),
                                          height: 15.h,
                                          width: 15.h,
                                        ),
                                        Text(
                                          "Profit:",
                                          style: AppTextStyles.customText12(
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.white.withOpacity(0.4),
                                          ),
                                        ).paddingLeft(4.w),
                                        Expanded(
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            "${controller.portfolioProfit.value.toString()}%",
                                            style: AppTextStyles.customText12(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    5.h.height,
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.negativeRed,
                                            shape: BoxShape.circle,
                                          ),
                                          height: 15.h,
                                          width: 15.h,
                                        ),
                                        5.w.width,
                                        Text(
                                          "Loss:",
                                          style: AppTextStyles.customText12(
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.white.withOpacity(0.4),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            "${controller.portfolioLoss.value.toString()}%",
                                            style: AppTextStyles.customText12(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ).paddingLeft(10.w),
                              ),
                            ),
                            10.w.width,
                            Expanded(
                              child: BlurContainer(
                                height: 170.h,
                                borderRadius: 10.sp,
                                child: Center(
                                  child: controller.coinPercentages.value.isEmpty
                                      ? Text(
                                    "Graph Not Available",
                                    style: AppTextStyles.customText11(
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  )
                                      : PieChartG(
                                    coinPercentages: controller.coinPercentages,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Fear and Greed Index Section
                      Animate(
                        effects: [
                          SlideEffect(
                            duration: 500.ms,
                            curve: Curves.easeOutBack,
                            begin: Offset(-1, 0),
                            end: Offset.zero,
                          ),
                          FadeEffect(
                            duration: 500.ms,
                            curve: Curves.easeInOut,
                          ),
                        ],
                        child: Text(
                          "Fear and Greed Index",
                          style: AppTextStyles.customText16(
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ).paddingTop(20.h),
                      ),

                      // Fear and Greed Slider Section
                      Animate(
                        effects: [
                          SlideEffect(
                            duration: 500.ms,
                            curve: Curves.easeOutBack,
                            begin: Offset(-1, 0),
                            end: Offset.zero,
                          ),
                          FadeEffect(
                            duration: 500.ms,
                            curve: Curves.easeInOut,
                          ),
                        ],
                        child: BlurContainer(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(() {
                                    return Text(
                                      controller.calculateFearGreedIndex((controller.fearGreedValue.value * 10).toInt()),
                                      style: AppTextStyles.customText14(color: AppColors.white),
                                    );
                                  }),
                                  Obx(() {
                                    return Text(
                                      '${controller.fearGreedValue.value}%',
                                      style: AppTextStyles.customText14(color: AppColors.white),
                                    );
                                  }),
                                ],
                              ).paddingHorizontal(23.w),
                              Obx(() {
                                return GradientSlider(
                                  thumbAsset: AppAssets.sliderThumbIcon,
                                  thumbHeight: 20.sp,
                                  trackHeight: 6.h,
                                  thumbWidth: 20.sp,
                                  activeTrackGradient: LinearGradient(
                                    colors: [
                                      AppColors.negativeRed,
                                      AppColors.negativeRed,
                                      Colors.yellowAccent,
                                      AppColors.positiveGreen,
                                      AppColors.positiveGreen,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  inactiveTrackGradient: LinearGradient(
                                    colors: [
                                      AppColors.negativeRed,
                                      Colors.yellowAccent,
                                      AppColors.positiveGreen,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  slider: Slider(
                                    min: 0.0,
                                    max: 100.0,
                                    value: controller.fearGreedValue.value,
                                    onChanged: (value) {
                                      // controller.changeFearGreedValue(value);
                                    },
                                  ),
                                );
                              }),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.arrow_drop_up_rounded,
                                        size: 25.sp,
                                        color: AppColors.white.withOpacity(0.5),
                                      ),
                                      Text(
                                        'Fear',
                                        style: AppTextStyles.customText10(
                                          color: AppColors.white.withOpacity(0.5),
                                          height: 0.1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.arrow_drop_up_rounded,
                                        size: 25.sp,
                                        color: AppColors.white.withOpacity(0.5),
                                      ),
                                      Text(
                                        'Neutral',
                                        style: AppTextStyles.customText10(
                                          color: AppColors.white.withOpacity(0.5),
                                          height: 0.1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.arrow_drop_up_rounded,
                                        size: 25.sp,
                                        color: AppColors.white.withOpacity(0.5),
                                      ),
                                      Text(
                                        'Greed',
                                        style: AppTextStyles.customText10(
                                          color: AppColors.white.withOpacity(0.5),
                                          height: 0.1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ).paddingHorizontal(23.w),
                            ],
                          ).paddingVertical(10.h),
                        ),
                      ),
                    ],
                  ),
                );
              }).paddingHorizontal(20.w),
            ),
          ),
        ),
      ),
    );
  }
}
