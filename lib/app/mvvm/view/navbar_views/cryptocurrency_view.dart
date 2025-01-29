import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:souq_ai/app/config/app_routes.dart';
import 'package:souq_ai/app/config/app_text_style.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import 'package:souq_ai/app/mvvm/view_model/cryptcurrency_controller.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../widgets/blur_container.dart';
import '../../../widgets/cached_image.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/textField.dart';
import '../../model/response_model/crypto_currenices_resp_model.dart';

class CryptocurrencyView extends StatefulWidget {
  const CryptocurrencyView({super.key});

  @override
  State<CryptocurrencyView> createState() => _CryptocurrencyViewState();
}

class _CryptocurrencyViewState extends State<CryptocurrencyView> with TickerProviderStateMixin {
  late TabController tabController;
  int animateIndex = 0;

  final CryptocurrencyController controller = Get.find();

  final List<Tab> tabsList = [
    const Tab(text: "All currencies"),
    const Tab(text: "Recently added"),
  ];

  @override
  void initState() {
    tabController = TabController(
      length: tabsList.length,
      vsync: this,
      animationDuration: const Duration(milliseconds: 500),
    );

    controller.resetPagination();
    controller.selectedTab = 'all';
    controller.fetchInstitutes(1);

    controller.setupScrollListener();

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
        title: 'Cryptocurrency Screening',
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
              (kToolbarHeight + 20).h.height,
              // CustomField(
              //   labelTitle: '',
              //   labelColor: AppColors.white,
              //   contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
              //   labelTextFontSize: 13.sp,
              //   textInputAction: TextInputAction.search,
              //   prefixIcon: Icon(Icons.search, color: AppColors.white, size: 25.sp),
              //   hintText: 'Search for a Signal',
              //   enabledBorderColor: AppColors.white,
              //   focusedBorderColor: AppColors.white,
              //   fillColor: AppColors.white.withOpacity(0.05),
              //   filled: true,
              // ),
              25.h.height,
              Obx(() {
                return AnimatedCrossFade(
                  crossFadeState: !controller.showPieChart.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  duration: Duration(milliseconds: 300),
                  firstChild: SizedBox.shrink(),
                  secondChild: controller.isLoading.value
                      ? Container(height: 200.h, child: Center(child: CustomActivityIndicator()))
                      : BlurContainer(
                          borderRadius: 10.sp,
                          child: Center(
                            child: Column(
                              children: [
                                PieChart(
                                  dataMap: controller.dataMap,
                                  animationDuration: Duration(milliseconds: 800),
                                  chartRadius: 200.sp,
                                  colorList: [
                                    Color(0xff6db36d),
                                    Color(0xffe0b950),
                                    Color(0xffea5247),
                                  ],
                                  initialAngleInDegree: 0,
                                  chartType: ChartType.disc,
                                  ringStrokeWidth: 32,
                                  legendOptions: LegendOptions(
                                    legendPosition: LegendPosition.bottom,
                                    showLegendsInRow: true,
                                    showLegends: false,
                                    legendShape: BoxShape.circle,
                                    legendTextStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  chartValuesOptions: ChartValuesOptions(
                                    decimalPlaces: 0,
                                    chartValueStyle: AppTextStyles.customText20(color: AppColors.white),
                                    showChartValueBackground: false,
                                    showChartValues: true,
                                    showChartValuesInPercentage: true,
                                    showChartValuesOutside: false,
                                  ),
                                ).paddingVertical(10.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 18.sp,
                                          width: 18.sp,
                                          decoration: BoxDecoration(color: Color(0xff6db36d), borderRadius: BorderRadius.circular(2.sp)),
                                        ),
                                        3.w.width,
                                        Text('Halal', style: AppTextStyles.customText12(color: AppColors.white))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 18.sp,
                                          width: 18.sp,
                                          decoration: BoxDecoration(color: Color(0xffe0b950), borderRadius: BorderRadius.circular(2.sp)),
                                        ),
                                        3.w.width,
                                        Text('Questionable', style: AppTextStyles.customText12(color: AppColors.white))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 18.sp,
                                          width: 18.sp,
                                          decoration: BoxDecoration(color: Color(0xffea5247), borderRadius: BorderRadius.circular(2.sp)),
                                        ),
                                        3.w.width,
                                        Text('Haram', style: AppTextStyles.customText12(color: AppColors.white))
                                      ],
                                    ),
                                  ],
                                ),
                                15.h.height,
                              ],
                            ).paddingHorizontal(15.w),
                          )),
                );
              }),
              10.h.height,
              Container(
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
                    controller.selectedTab = index == 0
                        ? "all"
                        : index == 1
                            ? "recent"
                            : null;
                    controller.fetchInstitutes(1);
                    controller.resetPagination();
                    print(controller.selectedTab);
                  },
                ).paddingVertical(6.sp),
              ).animate()
                  .fadeIn(duration: 800.ms, delay: 1200.ms)
                  .scale( duration: 1000.ms, curve: Curves.easeOutBack),
              10.h.height,
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
                      'Shariah status',
                      style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5)),
                    ),
                    Text(
                      'Action',
                      style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5)),
                    ),
                  ],
                ).paddingHorizontal(15.w).paddingVertical(10.h),
              ).animate()
                  .fadeIn(duration: 500.ms, delay: 600.ms)
                  .slide(begin: Offset(-30.w, 0), duration: 500.ms, curve: Curves.easeOutCubic),
              10.h.height,
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   padding: EdgeInsets.zero,
                    //   itemCount: tilesTitle.length,
                    //   itemBuilder: (context, index) {
                    //     return _buildTileForPortfolio(onDetailsTap: (){Get.toNamed(AppRoutes.screeningDetailView);}, title: tilesTitle[index], iconPath: AppAssets.btcIcon, status: index % 2 == 0 ? 'Halal' : 'Questionable', isPremium: index == 0);
                    //   },
                    // ),
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   padding: EdgeInsets.zero,
                    //   itemCount: tilesTitle.length,
                    //   itemBuilder: (context, index) {
                    //     return _buildTileForPortfolio(title: tilesTitle[index], iconPath: AppAssets.btcIcon, status: index % 2 == 0 ? 'Halal' : 'Questionable');
                    //   },
                    // ),

                    Obx(() {
                      return controller.isLoading.value
                          ? CustomActivityIndicator()
                          : RefreshIndicator(
                              onRefresh: () async {
                                controller.resetPagination();
                                controller.selectedTab = 'all';
                                await controller.fetchInstitutes(1);
                              },
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                controller: controller.scrollController,
                                itemCount: controller.hasMoreData.value ? controller.currenciesList.length + 1 : controller.currenciesList.length,
                                itemBuilder: (context, index) {
                                  if (index == controller.currenciesList.length) {
                                    return controller.hasMoreData.value
                                        ? Center(child: CustomActivityIndicator())
                                        : Padding(
                                            padding: EdgeInsets.all(30.sp),
                                            child: Text(
                                              "No currencies available",
                                              textAlign: TextAlign.center,
                                              style: AppTextStyles.customText12(
                                                color: AppColors.white,
                                              ),
                                            ),
                                          );
                                  }

                                  final currency = controller.currenciesList[index];

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
                                    child: _buildTileForPortfolio(
                                      onDetailsTap: () {
                                        Get.toNamed(
                                          AppRoutes.screeningDetailView,
                                          arguments: {
                                            'currency': Currency(
                                              id: currency.id,
                                              symbol: currency.symbol,
                                              type: currency.type,
                                              name: currency.name,
                                              icon: currency.icon,
                                              status: currency.status,
                                              mechanism: currency.mechanism,
                                              supply: currency.supply,
                                              marketCap: currency.marketCap,
                                              about: currency.about,
                                              services: currency.services,
                                              use: currency.use,
                                              visibility: currency.visibility,
                                            ),
                                          },
                                        );
                                      },
                                      isPremium: index == 0,
                                      title: currency.name?.capitalizeFirst ?? "",
                                      imageURL: currency.icon ?? "",
                                      status: currency.status,
                                    ),
                                  ).animate(); // Apply animations to each tile
                                },
                              ),
                            );
                    }),

                    Obx(() {
                      return controller.isLoading.value
                          ? Center(child: CustomActivityIndicator())
                          : RefreshIndicator(
                              onRefresh: () async {
                                controller.resetPagination();
                                controller.selectedTab = 'all';
                                await controller.fetchInstitutes(1);
                              },
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                controller: controller.scrollController,
                                itemCount: controller.hasMoreData.value
                                    ? controller.currenciesList.length + 1 // Include loader
                                    : controller.currenciesList.isNotEmpty
                                        ? controller.currenciesList.length
                                        : 1,
                                // Show "No currencies available" if empty
                                itemBuilder: (context, index) {
                                  // Show loader or "No currencies available"
                                  if (index == controller.currenciesList.length) {
                                    return controller.hasMoreData.value
                                        ? Center(child: CustomActivityIndicator())
                                        : Padding(
                                            padding: EdgeInsets.all(30.sp),
                                            child: Text(
                                              "No currencies available",
                                              textAlign: TextAlign.center,
                                              style: AppTextStyles.customText12(color: AppColors.white),
                                            ),
                                          );
                                  }

                                  // Show "No currencies available" for an empty list
                                  if (controller.currenciesList.isEmpty) {
                                    return Padding(
                                      padding: EdgeInsets.all(30.sp),
                                      child: Text(
                                        "No currencies available",
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.customText12(color: AppColors.white),
                                      ),
                                    );
                                  }

                                  // Render currency tile
                                  final currency = controller.currenciesList[index];
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
                                    child: _buildTileForPortfolio(
                                      onDetailsTap: () {
                                        Get.toNamed(
                                          AppRoutes.screeningDetailView,
                                          arguments: {
                                            'currency': Currency(
                                              id: currency.id,
                                              symbol: currency.symbol,
                                              type: currency.type,
                                              name: currency.name,
                                              icon: currency.icon,
                                              status: currency.status,
                                              mechanism: currency.mechanism,
                                              supply: currency.supply,
                                              marketCap: currency.marketCap,
                                              about: currency.about,
                                              services: currency.services,
                                              use: currency.use,
                                              visibility: currency.visibility,
                                            ),
                                          },
                                        );
                                      },
                                      title: currency.name?.capitalizeFirst ?? "",
                                      imageURL: currency.icon ?? "",
                                      status: currency.status,
                                    ),
                                  );
                                },
                              ));
                    })
                  ],
                ),
              ),
              80.h.height,
            ],
          ).paddingHorizontal(15.w),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Obx(() {
        return FloatingActionButton(
          mini: true,
          onPressed: () {
            controller.showPieChart.value = !controller.showPieChart.value;
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
          backgroundColor: AppColors.primary,
          child: controller.showPieChart.value
              ? Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                )
              : SvgPicture.asset(
                  AppAssets.graphIcon,
                  color: Colors.white,
                ),
        );
      }).paddingBottom(80.h),
    );
  }

  Widget _buildTileForPortfolio({required String title, double? height, required String imageURL, bool isPremium = false, String? status, VoidCallback? onDetailsTap}) {
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
            .8
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CachedImage(
                  height: 40.sp,
                  width: 40.sp,
                  imageUrl: imageURL,
                  borderRadius: 40.sp / 2, // Circle shape
                ),
                10.w.width,
                Text(isPremium ? "For Premium users only" : title, style: AppTextStyles.customText12(color: AppColors.white, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          if (!isPremium)
            Text(
              status?.capitalizeFirst ?? 'Halal',
              style: AppTextStyles.customText10(
                  color: status!.toLowerCase() == 'halal'
                      ? Colors.green
                      : status.toLowerCase() == 'haram'
                          ? Colors.red
                          : Colors.yellow),
            ),
          if (!isPremium)
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: onDetailsTap,
                  child: BlurContainer(
                    width: 70.w,
                    borderRadius: 5.sp,
                    child: Center(
                      child: Text(
                        'Details',
                        style: AppTextStyles.customText12(color: AppColors.white),
                      ),
                    ).paddingVertical(6.h).paddingHorizontal(10.w),
                  ),
                ),
              ),
            )
        ],
      ).paddingHorizontal(8.w).paddingVertical(8.h),
    ).paddingBottom(10.h);
  }
}
