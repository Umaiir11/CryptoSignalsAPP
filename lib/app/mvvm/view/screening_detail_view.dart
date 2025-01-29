import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:souq_ai/app/config/app_colors.dart';
import 'package:souq_ai/app/config/app_text_style.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import '../../config/app_assets.dart';
import '../../widgets/custom_app_bar.dart';
import '../model/response_model/crypto_currenices_resp_model.dart';
import '../view_model/cryptcurrency_controller.dart';

class ScreeningDetailView extends StatefulWidget {
  const ScreeningDetailView({super.key});

  @override
  State<ScreeningDetailView> createState() => _ScreeningDetailViewState();
}

class _ScreeningDetailViewState extends State<ScreeningDetailView> with TickerProviderStateMixin {
  late TabController tabController;
  final List<Tab> tabsList = [
    const Tab(text: "About"),
    const Tab(text: "Services"),
    const Tab(text: "Use"),
  ];
  final CryptocurrencyController controller = Get.find();

  @override
  void initState() {
    tabController = TabController(
      length: tabsList.length,
      vsync: this,
      animationDuration: const Duration(milliseconds: 500),
    );
    final args = Get.arguments;
    controller.currencyDetailsModel = args['currency'];
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        elevation: 0.0,
        title: 'Screening Detail',
        backgroundColor: Colors.transparent,
        centerTitle: false,
      ),
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(AppAssets.bgImage), fit: BoxFit.cover)),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Adjust blur intensity
            child: Column(
              children: [
                (kToolbarHeight + 60).h.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ',
                      style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5)),
                    ),
                    Text(
                      controller.currencyDetailsModel?.name?.capitalizeFirst ?? "",
                      style: AppTextStyles.customText16(color: AppColors.white),
                    ),
                  ],
                ),
                10.h.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Consensus Mechanism: ',
                      style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5)),
                    ),
                    Text(
                      controller.currencyDetailsModel?.mechanism?.capitalizeFirst ?? "",
                      style: AppTextStyles.customText16(color: AppColors.white),
                    ),
                  ],
                ),
                10.h.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Circulating Supply: ',
                      style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5)),
                    ),
                    Text(
                      controller.currencyDetailsModel?.supply.toString() ?? "",
                      style: AppTextStyles.customText16(color: AppColors.white),
                    ),
                  ],
                ),
                10.h.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Market Cap: ',
                      style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5)),
                    ),
                    Text(
                      controller.currencyDetailsModel?.marketCap.toString() ?? "",
                      style: AppTextStyles.customText16(color: AppColors.white),
                    ),
                  ],
                ),
                10.h.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Type: ',
                      style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5)),
                    ),
                    Text(
                      controller.currencyDetailsModel?.type?.capitalizeFirst ?? "",
                      style: AppTextStyles.customText16(color: AppColors.white),
                    ),
                    // 10.w.width,
                    // Container(
                    //   height: 25.h,
                    //   width: 77.w,
                    //   decoration: BoxDecoration(
                    //     color: AppColors.transparent,
                    //     borderRadius: BorderRadius.circular(5.sp),
                    //     border: Border.all(color: AppColors.primary.withOpacity(0.5))
                    //   ),
                    // ),
                    // 10.w.width,
                    // Container(
                    //   height: 25.h,
                    //   width: 77.w,
                    //   decoration: BoxDecoration(
                    //     color: AppColors.transparent,
                    //     borderRadius: BorderRadius.circular(5.sp),
                    //     border: Border.all(color: AppColors.primary.withOpacity(0.5))
                    //   ),
                    // ),
                  ],
                ),
                10.h.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Shariah Status: ',
                      style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5)),
                    ),
                    Text(
                      controller.currencyDetailsModel?.status?.capitalizeFirst ?? "",
                      style: AppTextStyles.customText16(color: AppColors.white),
                    ),
                  ],
                ),
                10.h.height,
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp),
                      color: Colors.transparent,
                    ),
                    child: TabBar(
                      isScrollable: false,
                      tabs: tabsList.map((tab) {
                        int index = tabsList.indexOf(tab);
                        bool isSelected = tabController.index == index;
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected ? Colors.transparent : AppColors.primary.withOpacity(0.8), // Hide border when selected
                            ),
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: Tab(text: tabsList[index].text).paddingHorizontal(10.w),
                        );
                      }).toList(),
                      controller: tabController,
                      indicatorColor: AppColors.primary,
                      labelColor: AppColors.white,
                      labelPadding: EdgeInsets.symmetric(horizontal: 4.sp),
                      enableFeedback: false,
                      splashFactory: NoSplash.splashFactory,
                      overlayColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
                      indicatorSize: TabBarIndicatorSize.label,
                      dividerColor: AppColors.transparent,
                      unselectedLabelColor: AppColors.white.withOpacity(0.5),
                      labelStyle: AppTextStyles.customText16(color: AppColors.black),
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.sp),
                          color: AppColors.primary.withOpacity(0.8),
                          gradient: LinearGradient(colors: [Color(0xff30F6B2), Color(0xff24B986)], begin: Alignment.centerLeft, end: Alignment.centerRight, stops: [0.01, 0.9])),
                      onTap: (index) {
                        setState(() {});
                      },
                    ).paddingVertical(6.sp),
                  ),
                ),
                15.h.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Overview',
                      style: AppTextStyles.customText16(color: AppColors.white),
                    )
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: [
                      Text(controller.currencyDetailsModel?.about?.capitalizeFirst ?? "",
                          style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5)), textAlign: TextAlign.start),
                      Text(controller.currencyDetailsModel?.services?.capitalizeFirst ?? "",
                          style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5)), textAlign: TextAlign.start),
                      Text(controller.currencyDetailsModel?.use?.capitalizeFirst ?? "",
                          style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5)), textAlign: TextAlign.start),
                    ],
                  ),
                )
              ],
            ).paddingHorizontal(17.w)),
      ),
    );
  }
}
