import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:souq_ai/app/config/app_routes.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import 'package:souq_ai/app/mvvm/view_model/zakat_controller.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_text_style.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/textField.dart';

class ZakatView extends StatefulWidget {
  const ZakatView({super.key});

  @override
  State<ZakatView> createState() => _ZakatViewState();
}

class _ZakatViewState extends State<ZakatView> {
  @override
  final ZakatController controller = Get.find();

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Ensures layout adjusts when the keyboard appears

      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        elevation: 0.0,
        title: 'Zakat Calculation',
        backgroundColor: Colors.transparent,
        leadingWidth: 0.w,
        leading: SizedBox.shrink(),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (kToolbarHeight + 50).h.height,
                CustomField(
                  controller: controller.amountController,
                  onChanged: controller.calculateZakat,
                  // Call the method on every input change
                  keyboardType: TextInputType.number,
                  labelTitle: 'Amount',
                  labelColor: AppColors.white,
                  labelTextFontSize: 13.sp,
                  hintText: '\$ 12,000',
                  enabledBorderColor: AppColors.white,
                  textInputAction: TextInputAction.done,
                  focusedBorderColor: AppColors.white,
                  fillColor: AppColors.white.withOpacity(0.05),
                  filled: true,
                ).animate()
                    .fadeIn(duration: 500.ms, delay: 800.ms)
                    .slide(begin: Offset(30.w, 0), duration: 500.ms, curve: Curves.easeOutCubic),
                20.h.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Gold', style: AppTextStyles.customText16(color: AppColors.white)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(AppAssets.exchangeIcon),
                        10.w.width,
                        Text('Silver', style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5))),
                      ],
                    ),
                  ],
                ).animate()
                    .fadeIn(duration: 500.ms, delay: 600.ms)
                    .slide(begin: Offset(-30.w, 0), duration: 500.ms, curve: Curves.easeOutCubic), //left,
                6.h.height,
                Text(
                  "Today's Nisab (threshold) based on gold (85 grams of gold =4,500)",
                  textAlign: TextAlign.start,
                  style: AppTextStyles.customText10(color: AppColors.white.withOpacity(0.5)),
                ).animate()
                    .fadeIn(duration: 500.ms, delay: 800.ms)
                    .slide(begin: Offset(30.w, 0), duration: 500.ms, curve: Curves.easeOutCubic), // Slide from right,
                6.h.height,
                Container(
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Zakat Owed:  ', style: AppTextStyles.customText14(color: AppColors.white.withOpacity(0.5))),
                      Obx(() {
                        return Text('\$${controller.zakatValue.value} (2.5%)', style: AppTextStyles.customText14(color: AppColors.white));
                      }),
                    ],
                  ).paddingLeft(15.w).paddingVertical(17.h),
                ).animate()
                    .fadeIn(duration: 500.ms, delay: 600.ms)
                    .slide(begin: Offset(-30.w, 0), duration: 500.ms, curve: Curves.easeOutCubic), //left,
                const Spacer(),
                CustomButton(
                  height: 60.sp,
                  borderRadius: 10.sp,
                  title: "View Charity Institutes",
                  isGradientEnabled: true,

                  onPressed: () {
                    Get.toNamed(AppRoutes.charityInstituteView);
                  },
                ).animate()
                    .fadeIn(duration: 800.ms, delay: 1200.ms)
                    .scale( duration: 1000.ms, curve: Curves.easeOutBack),
                100.h.height,
              ],
            )
                .paddingHorizontal(17.w),
          ),
        ),
      ),
    );
  }
}
