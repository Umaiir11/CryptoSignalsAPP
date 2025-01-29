import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import 'package:souq_ai/app/mvvm/view_model/auth_controllers/signal_controller.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_text_style.dart';
import '../../../widgets/blur_container.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/expandable_trade_card.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/textField.dart';

class SignalView extends StatefulWidget {
  const SignalView({super.key});

  @override
  State<SignalView> createState() => _SignalViewState();
}

class _SignalViewState extends State<SignalView> {
  final SignalController controller = Get.find();

  void initState() {
    controller.resetPagination();
    controller.fetchSignals(1);
    controller.setupScrollListener();
    controller.searchController.addListener(() {
      controller.filterSignals(controller.searchController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        elevation: 0.0,
        title: 'Crypto Signal',
        backgroundColor: Colors.transparent,
        leadingWidth: 0.w,
        leading: SizedBox.shrink(),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (kToolbarHeight + 50).h.height,
              Row(
                children: [
                  Expanded(
                    child: CustomField(
                      controller: controller.searchController,
                      titleWidget: null,
                      labelColor: AppColors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 11.h),
                      labelTextFontSize: 13.sp,
                      prefixIcon: Icon(Icons.search, color: AppColors.white, size: 25.sp),
                      hintText: 'Search for Signal Based on Currency Name',
                      enabledBorderColor: AppColors.white,
                      focusedBorderColor: AppColors.white,
                      fillColor: AppColors.white.withOpacity(0.05),
                      filled: true,
                    ),
                  ),
                  6.w.width,
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.bottomSheet(Container(
                  //       width: 1.sw,
                  //       decoration: BoxDecoration(
                  //         color: AppColors.primary,
                  //         borderRadius: BorderRadius.only(
                  //           topLeft: Radius.circular(10.sp),
                  //           topRight: Radius.circular(10.sp),
                  //         ),
                  //       ),
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           GestureDetector(
                  //             onTap: () {
                  //               Get.back();
                  //             },
                  //             child: Container(
                  //                 height: 56.h,
                  //                 alignment: Alignment.center,
                  //                 decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(10.sp),
                  //                     border: Border(
                  //                       top: BorderSide(color: Colors.white.withOpacity(0.4)),
                  //                     )),
                  //                 child: Text(
                  //                   "7 Days",
                  //                   style: AppTextStyles.customText16(color: Colors.white, fontWeight: FontWeight.w600),
                  //                 )),
                  //           ),
                  //           GestureDetector(
                  //             onTap: () {
                  //               Get.back();
                  //             },
                  //             child: Container(
                  //                 height: 56.h,
                  //                 alignment: Alignment.center,
                  //                 decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(10.sp),
                  //                     border: Border(
                  //                       top: BorderSide(color: Colors.white.withOpacity(0.4)),
                  //                     )),
                  //                 child: Text(
                  //                   "14 Days",
                  //                   style: AppTextStyles.customText16(color: Colors.white, fontWeight: FontWeight.w600),
                  //                 )),
                  //           ),
                  //           GestureDetector(
                  //             onTap: () {
                  //               Get.back();
                  //             },
                  //             child: Container(
                  //                 height: 56.h,
                  //                 alignment: Alignment.center,
                  //                 decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(10.sp),
                  //                     border: Border(
                  //                       top: BorderSide(color: Colors.white.withOpacity(0.4)),
                  //                     )),
                  //                 child: Text(
                  //                   "30 Days",
                  //                   style: AppTextStyles.customText16(color: Colors.white, fontWeight: FontWeight.w600),
                  //                 )),
                  //           ),
                  //         ],
                  //       ),
                  //     ));
                  //   },
                  //   child: BlurContainer(
                  //     height: 48.h,
                  //     width: 50.w,
                  //     child: Center(
                  //       child: SvgPicture.asset(AppAssets.filterIcon),
                  //     ),
                  //   ),
                  // )
                ],
              ).animate()
                  .fadeIn(duration: 800.ms, delay: 1200.ms)
                  .scale( duration: 1000.ms, curve: Curves.easeOutBack),
              20.h.height,
              Obx(() {
                return controller.isLoading.value
                    ? Expanded(child: Center(child: CustomActivityIndicator()))
                    : Expanded(
                        child: RefreshIndicator(
                            onRefresh: () async {
                              controller.resetPagination();

                              await controller.fetchSignals(1);
                            },
                            child: ListView.builder(

                              padding: EdgeInsets.zero,
                              itemCount: controller.hasMoreData.value
                                  ? controller.filteredSignalsList.length + 1 // Include loader
                                  : controller.filteredSignalsList.isNotEmpty
                                      ? controller.filteredSignalsList.length
                                      : 1,
                              // Show "No signals available" if empty
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: controller.scrollController,
                              itemBuilder: (context, index) {
                                // Show loader or "No signals available"
                                if (index == controller.filteredSignalsList.length) {
                                  return controller.hasMoreData.value
                                      ? Center(child: CustomActivityIndicator())
                                      : Padding(
                                          padding: EdgeInsets.all(30.sp),
                                          child: Text(
                                            "No signals available",
                                            textAlign: TextAlign.center,
                                            style: AppTextStyles.customText12(color: AppColors.white),
                                          ),
                                        );
                                }

                                // Handle empty filteredSignalsList
                                if (controller.filteredSignalsList.isEmpty) {
                                  return Padding(
                                    padding: EdgeInsets.all(30.sp),
                                    child: Text(
                                      "No signals available",
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.customText12(color: AppColors.white),
                                    ),
                                  );
                                }

                                // Signal data for the tile
                                final signal = controller.filteredSignalsList[index];
                                double? currentPrice = signal.currentPrice;
                                double? closedPrice = signal.closedPrice;
                                double? comparisonPrice = currentPrice != 0.0 ? currentPrice : closedPrice;

                                // Conditions for TP/SL fills
                                bool isTp1Filled = comparisonPrice != null && comparisonPrice > (signal.tp1 ?? double.infinity);
                                bool isTp2Filled = comparisonPrice != null && comparisonPrice > (signal.tp2 ?? double.infinity);
                                bool isTp3Filled = comparisonPrice != null && comparisonPrice > (signal.tp3 ?? double.infinity);
                                bool isSlFilled = comparisonPrice != null && comparisonPrice < (signal.sl ?? -double.infinity);

                                // ExpandableTradeCard widget
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
                                  child: ExpandableTradeCard(
                                    title: signal.currency?.name ?? "",
                                    currentPrice: signal.currentPrice?.toStringAsFixed(2) ?? "N/A",
                                    buyingRange: "${signal.buyFrom?.toStringAsFixed(1) ?? "N/A"} - ${signal.buyTo?.toStringAsFixed(1) ?? "N/A"}",
                                    source: signal.source ?? "",
                                    dateTime: signal.createdAt ?? "",
                                    imageURL: signal.currency?.icon ?? "",
                                    tp1: signal.tp1?.toStringAsFixed(1) ?? "N/A",
                                    tp2: signal.tp2?.toStringAsFixed(1) ?? "N/A",
                                    tp3: signal.tp3?.toStringAsFixed(1) ?? "N/A",
                                    tp4: signal.sl?.toStringAsFixed(1) ?? "N/A",
                                    isS1Filled: isSlFilled,
                                    isTp1Filled: isTp1Filled,
                                    isTp2Filled: isTp2Filled,
                                    isTp3Filled: isTp3Filled,
                                    border: Border(
                                      top: BorderSide(
                                        color: signal.isActive == 1 ? Colors.white.withOpacity(0.1) : Colors.red,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )),
                      );
              }),
              80.h.height,
            ],
          ).paddingHorizontal(16.w),
        ),
      ),
    );
  }
}
