import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import 'package:souq_ai/app/widgets/blur_container.dart';
import 'package:souq_ai/app/widgets/custom_app_bar.dart';
import 'package:souq_ai/app/widgets/dialogs/add_currency_dialog.dart';
import 'package:souq_ai/app/widgets/loader.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_text_style.dart';
import '../../../widgets/cached_image.dart';
import '../../../widgets/charts/home_chart.dart';
import '../../../widgets/textField.dart';
import '../../view_model/portfolio_controller.dart';

class PortfolioView extends StatefulWidget {
  const PortfolioView({super.key});

  @override
  State<PortfolioView> createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> {
  final PortfolioController controller = Get.find();

  // List<String> tilesTitle = [
  //   'Binance',
  //   'Ethereum',
  //   'Bitcoin(BTC)',
  //   'Binance',
  // ];

  @override
  void initState() {
    // TODO: implement initState
    controller.fetchPortfolioApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          trailing: GestureDetector(
            onTap: () {
              Get.dialog(
                  AddCurrencyDialog(
                    portfolioController: controller,
                  ),
                  barrierDismissible: false);
            },
            child: BlurContainer(
              borderRadius: 5.sp,
              height: 30.h,
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: AppColors.white,
                    size: 15.sp,
                  ),
                  2.w.width,
                  Text(
                    'Add',
                    style: AppTextStyles.customText10(color: AppColors.white),
                  )
                ],
              ).paddingHorizontal(10.w)),
            ).paddingRight(5.w).animate()
                .fadeIn(duration: 800.ms, delay: 1200.ms)
                .scale( duration: 1000.ms, curve: Curves.easeOutBack),
          ),
          elevation: 0.0,
          leading: SizedBox.shrink(),
          title: 'Portfolio',
          leadingWidth: 2.w,
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
            child: Obx(() {
              return
                controller.isPortfolioLoading.value
                  ? Center(child: CustomActivityIndicator())
                  : (controller.portfolioList?.value ?? [])!.isEmpty ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Icon(Icons.error_outline, color: Colors.white.withOpacity(0.9), size: 24.sp,),
                    6.h.height,
                    Text("Portfolio Not Available", style: AppTextStyles.customText20(color: Colors.white.withOpacity(0.8)),)

                  ],
                                  ) :

                Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          (kToolbarHeight + 20).h.height,
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Expanded(
                          //       child: CustomField(
                          //         labelTitle: '',
                          //         labelColor: AppColors.white,
                          //         contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                          //         labelTextFontSize: 13.sp,
                          //         prefixIcon: Icon(Icons.search, color: AppColors.white, size: 25.sp),
                          //         hintText: 'Search for a Signal',
                          //         enabledBorderColor: AppColors.white,
                          //         focusedBorderColor: AppColors.white,
                          //         fillColor: AppColors.white.withOpacity(0.05),
                          //         filled: true,
                          //       ),
                          //     ),
                          //     6.w.width,
                          //     BlurContainer(
                          //       height: 53.h,
                          //       width: 50.w,
                          //       child: Center(
                          //         child: SvgPicture.asset(AppAssets.filterIcon),
                          //       ),
                          //     ).paddingTop(25.h)
                          //   ],
                          // ),
                          20.h.height,
                          Row(
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
                                        Text("USD",
                                            style: AppTextStyles.customText28(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.white,
                                            )),
                                        Text(
                                          controller.currentPortfolioTotal.value.toString().length > 7
                                              ? controller.currentPortfolioTotal.value.toString().substring(0, 7)
                                              : controller.currentPortfolioTotal.value.toString(),
                                          style: AppTextStyles.customText28(
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.white,
                                          ),
                                          overflow: TextOverflow.ellipsis, // Handles overflow gracefully
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(color: AppColors.positiveGreen, shape: BoxShape.circle),
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
                                              decoration: BoxDecoration(color: AppColors.negativeRed, shape: BoxShape.circle),
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
                                    ).paddingLeft(10.w)),
                              ),
                              10.w.width,
                              Expanded(child: BlurContainer(height: 170.h, borderRadius: 10.sp, child: Center(child: PieChartG(coinPercentages: controller.coinPercentages,)))),
                            ],
                          )..animate()
                              .fadeIn(duration: 500.ms, delay: 800.ms)
                  .slide(begin: Offset(30.w, 0), duration: 500.ms, curve: Curves.easeOutCubic),
                          10.h.height,
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                await controller.fetchPortfolioApi();
                              },
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                // physics: BouncingScrollPhysics(),
                                itemCount: controller.portfolioList?.length,
                                itemBuilder: (context, index) {
                                  final portfolio = controller.portfolioList?[index];
                                  portfolio?.amount;
                                  portfolio?.currentPrice;
                                  String? currentP = (portfolio?.amount != null && portfolio?.currentPrice != null && portfolio?.currentPrice != 0)
                                      ? (portfolio!.currentPrice! / portfolio.amount!).toStringAsFixed(3) // Round to 3 decimal places
                                      : null;

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
                                    child: PortfolioTile(
                                        onTapEdit: () {
                                          controller.selectedPortfolioId = portfolio?.id;

                                          Get.dialog(
                                              EditAmountDialog(
                                                portfolioController: controller,
                                                editAmount: portfolio?.amount,
                                              ),
                                              barrierDismissible: false);
                                        },
                                        onTapDelete: () {
                                          controller.selectedPortfolioId = portfolio?.id;

                                          Get.dialog(
                                              DeleteDialog(
                                                portfolioController: controller,
                                              ),
                                              barrierDismissible: false);
                                        },
                                        title: portfolio?.currency?.name?.capitalizeFirst ?? "N/A",
                                        imageURL: portfolio?.currency?.icon ?? "N/A",
                                        coinsOwned: portfolio?.amount != null ? portfolio!.amount!.toStringAsFixed(1) : "",
                                        totalValue: portfolio?.currentPrice != null ? portfolio!.currentPrice!.toStringAsFixed(4) : "",
                                        currentPrice: currentP),
                                  );
                                },
                              ),
                            ),
                          ),
                          80.h.height,
                        ],
                      );
            }).paddingHorizontal(15.w),
          ),
        ));
  }
}

class PortfolioTile extends StatefulWidget {
  final String title;
  final double? height;
  final String imageURL;
  final String? totalValue;
  final String? coinsOwned;
  final String? currentPrice;
  final VoidCallback? onTap;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapDelete;

  const PortfolioTile({
    super.key,
    required this.title,
    this.height,
    required this.imageURL,
    this.totalValue,
    this.coinsOwned,
    this.currentPrice,
    this.onTap,
    this.onTapEdit, // Constructor assignment
    this.onTapDelete, // Constructor assignment
  });

  @override
  State<PortfolioTile> createState() => _PortfolioTileState();
}

class _PortfolioTileState extends State<PortfolioTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
        widget.onTap?.call();
      },
      child: Container(
        height: widget.height,
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CachedImage(
                        height: 40.sp,
                        width: 40.sp,
                        imageUrl: widget.imageURL,
                        borderRadius: 40.sp / 2, // Circle shape
                      ),
                      10.w.width,
                      Text(widget.title, style: AppTextStyles.customText14(color: AppColors.white, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${widget.coinsOwned?.toString()}", style: AppTextStyles.customText20(color: AppColors.white, fontWeight: FontWeight.w600)),
                    Text('Coins Owned', style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5), fontWeight: FontWeight.w400)),
                  ],
                ),
                10.w.width,
                PopupMenuButton<int>(
                  color: const Color(0xff343636),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints.tightFor(
                    width: 100.sp,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13.sp),
                      topRight: Radius.circular(4.sp),
                      bottomLeft: Radius.circular(13.sp),
                      bottomRight: Radius.circular(13.sp),
                    ),
                  ),
                  child: SvgPicture.asset(AppAssets.moreIcon).paddingFromAll(2.sp),
                  itemBuilder: (BuildContext bc) {
                    return [
                      PopupMenuItem<int>(
                        onTap: widget.onTapDelete,
                        // Trigger delete callback
                        value: 1,
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        height: 20.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(AppAssets.delIcon),
                            5.w.width,
                            Text(
                              'Remove',
                              style: AppTextStyles.customText12(
                                color: AppColors.negativeRed,
                                fontWeight: FontWeight.w500,
                              ).copyWith(fontSize: 11.sp),
                            ),
                          ],
                        ).paddingFromAll(5.sp).paddingBottom(5.h),
                      ),
                      PopupMenuItem<int>(
                        onTap: widget.onTapEdit,
                        // Trigger edit callback
                        value: 2,
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        height: 20.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(AppAssets.editIcon),
                            5.w.width,
                            Text(
                              'Edit',
                              style: AppTextStyles.customText12(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                              ).copyWith(fontSize: 11.sp),
                            ),
                          ],
                        ).paddingFromAll(5.sp),
                      ),
                    ];
                  },
                ),
              ],
            ).paddingHorizontal(15.w).paddingVertical(8.h),
            AnimatedCrossFade(
              firstChild: const SizedBox(
                width: double.infinity,
              ),
              secondChild: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("\$${widget.currentPrice?.toString()}", style: AppTextStyles.customText20(color: AppColors.white, fontWeight: FontWeight.w600)),
                          Text('Current Price', style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5), fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("\$${widget.totalValue?.toString()}", style: AppTextStyles.customText20(color: AppColors.white, fontWeight: FontWeight.w600)),
                          Text('Total Value', style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5), fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  ),
                ],
              ).paddingHorizontal(15.w).paddingVertical(8.h),
              crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ).paddingBottom(10.h),
    );
  }
}