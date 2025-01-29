import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';

import '../config/app_assets.dart';
import '../config/app_colors.dart';
import '../config/app_text_style.dart';
import 'cached_image.dart';

class ExpandableTradeCard extends StatefulWidget {
  final String title;
  final String currentPrice;
  final String buyingRange;
  final String source;
  final String dateTime;
  final VoidCallback? onTap;
  final bool isPremium;
  final Border? border;
  final String imageURL;
  final String tp1;
  final String tp2;
  final String tp3;
  final String tp4;
  final bool? isTp1Filled;
  final bool? isTp2Filled;
  final bool? isTp3Filled;
  final bool? isS1Filled;

  const ExpandableTradeCard({
    super.key,
    required this.title,
    required this.currentPrice,
    required this.buyingRange,
    required this.source,
    required this.dateTime,
    this.onTap,
    this.isPremium = false,
    this.border,
    required this.imageURL,
    required this.tp1,
    required this.tp2,
    required this.tp3,
    required this.tp4,
    this.isTp1Filled,
    this.isTp2Filled,
    this.isTp3Filled,
    this.isS1Filled,
  });

  @override
  _ExpandableTradeCardState createState() => _ExpandableTradeCardState();
}

class _ExpandableTradeCardState extends State<ExpandableTradeCard> with SingleTickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isPremium) {
          setState(() {
            isExpanded = !isExpanded;
          });
          if (widget.onTap != null) {
            widget.onTap?.call();
          }
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
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
          border: widget.border ?? Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
          // border: GradientBoxBorder(
          //   gradient: LinearGradient(colors: [
          //     AppColors.white.withOpacity(.2),
          //     AppColors.white.withOpacity(.02),
          //   ], stops: [
          //     .3,
          //     .8
          //   ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          //   width: 1,
          // ),
        ),
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      height: 50.sp,
                      width: 50.sp,
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.09),
                        shape: BoxShape.circle,
                      ),
                      child: CachedImage(
                        height: 40.sp,
                        width: 40.sp,
                        imageUrl: widget.imageURL,
                        borderRadius: 40.sp / 2, // Circle shape
                      ),
                    ),
                    10.w.width,
                    Text(widget.isPremium ? "For premium users only" : widget.title, style: AppTextStyles.customText16(color: AppColors.white, fontWeight: FontWeight.w500)),
                  ],
                ),
                if (!widget.isPremium) ...[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.currentPrice,
                            style: AppTextStyles.customText20(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Current Price',
                            style: AppTextStyles.customText14(
                              color: AppColors.white.withOpacity(0.5),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Check icon for TP1
                      if (widget.isTp1Filled == true)
                        SvgPicture.asset(AppAssets.checkIcon, color: Colors.white),

                      // Check icon for TP2
                      if (widget.isTp2Filled == true)
                        SvgPicture.asset(AppAssets.checkIcon, color: Colors.white),

                      // Check icon for TP3
                      if (widget.isTp3Filled == true)
                        SvgPicture.asset(AppAssets.checkIcon, color: Colors.white),

                      // Close icon if SL is filled
                      if (widget.isS1Filled == true)
                        SvgPicture.asset(AppAssets.closeIcon, color: Colors.red),

                      // Close icon if all are false
                      if ((widget.isTp1Filled != true &&
                          widget.isTp2Filled != true &&
                          widget.isTp3Filled != true &&
                          widget.isS1Filled != true))
                        SvgPicture.asset(AppAssets.closeIcon, color: Colors.red),
                    ],
                  ),
                ]
              ],
            ),

            /// Expanded content (only visible when expanded)
            if (!widget.isPremium)
              AnimatedCrossFade(
                firstChild: SizedBox.shrink(),
                secondChild: Column(
                  children: [
                    10.h.height,
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Buying Range:  ",
                            style: AppTextStyles.customText14(
                              color: AppColors.white.withOpacity(0.5),
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: widget.buyingRange,
                                style: AppTextStyles.customText14(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    10.h.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TradeInfoCard(
                            label: "TP 1:",
                            value: widget.tp1,
                            color: AppColors.primary,
                            filled: widget.isTp1Filled ?? false,
                          ),
                        ),
                        6.w.width,
                        Expanded(
                          child: TradeInfoCard(label: "TP 2:", value: widget.tp2, color: AppColors.primary, filled: widget.isTp2Filled ?? false),
                        ),
                        6.w.width,
                        Expanded(
                          child: TradeInfoCard(
                            label: "TP 3:",
                            value: widget.tp3,
                            color: AppColors.primary,
                            filled: widget.isTp3Filled ?? false,
                          ),
                        ),
                        6.w.width,
                        Expanded(
                          child: TradeInfoCard(label: "Sl:", value: widget.tp4, color: AppColors.negativeRed, filled: widget.isS1Filled ?? false),
                        ),
                      ],
                    ),
                    12.h.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "Source: ",
                            children: [
                              TextSpan(text: widget.source, style: AppTextStyles.customText(fontSize: 13.sp, color: Colors.white)),
                            ],
                          ),
                          style: AppTextStyles.customText(color: Colors.white70, fontSize: 12.sp),
                        ),
                        Text(
                          widget.dateTime,
                          style: AppTextStyles.customText(color: Colors.white.withOpacity(0.5), fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ],
                ),
                crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: Duration(milliseconds: 300),
              ),
          ],
        ),
      ).paddingBottom(10.h),
    );
  }
}

class TradeInfoCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final bool filled;

  const TradeInfoCard({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.sp),
        border: Border.all(color: color),
        color: filled ? color : Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.7)),
          ),
          Text(
            value,
            style: AppTextStyles.customText14(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
