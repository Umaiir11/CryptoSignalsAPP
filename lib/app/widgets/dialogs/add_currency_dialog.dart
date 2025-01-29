import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:souq_ai/app/config/app_colors.dart';
import 'package:souq_ai/app/config/app_text_style.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import 'package:souq_ai/app/widgets/loader.dart';
import '../../config/global_variables.dart';
import '../../mvvm/model/response_model/crypto_symbols.dart';
import '../../mvvm/view_model/portfolio_controller.dart';
import '../button.dart';
import '../custom_snackbar.dart';
import '../souq_dropdown.dart';
import '../textField.dart';

class AddCurrencyDialog extends StatefulWidget {
  final PortfolioController portfolioController;

  const AddCurrencyDialog({super.key, required this.portfolioController});

  @override
  State<AddCurrencyDialog> createState() => _AddCurrencyDialogState();
}

class _AddCurrencyDialogState extends State<AddCurrencyDialog> {
  final TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    widget.portfolioController.fetchPortfolioCurrenciesSymbolsApi();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
        backgroundColor: Color(0xff0A0B0A),
        shape: buildOutlineInputBorder(borderRadius: 21.sp, color: AppColors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.close, size: 20.sp, color: AppColors.white)),
              ],
            ),
            Text('Add Currency', style: AppTextStyles.customText24(color: AppColors.white, fontWeight: FontWeight.w400)),
            30.h.height,
            Obx(() {
              return widget.portfolioController.isPortfolioCurrenciesLoading.value
                  ? CustomActivityIndicator()
                  : SouqSymbolDropdownWidget<CurrencySymbols>(
                      items: widget.portfolioController.allCurrenciesSymbolsList?.value ?? [],
                      selectedValue: widget.portfolioController.selectedCurrency,
                      hintText: "Crypto Type",
                      textStyle: const TextStyle(color: Colors.white),
                      hintTextStyle: const TextStyle(color: Colors.white54, fontSize: 14),
                      onChanged: (CurrencySymbols? newValue) {
                        setState(() {
                          widget.portfolioController.selectedCurrency = newValue;
                          if (newValue != null) {
                            print("Selected Currency ID: ${newValue.id}");
                            widget.portfolioController.selectedSymbolId = newValue.id;
                          }
                        });
                      },
                    );
            }),
            15.h.height,
            Form(
              key: _formKey,
              child: CustomField(
                keyboardType: TextInputType.number,
                controller: amountController,
                textInputAction: TextInputAction.done,
                labelColor: AppColors.white,
                labelTextFontSize: 13.sp,
                hintText: 'Amount',
                hintTextFontSize: 14.sp,
                hintColor: Colors.white.withOpacity(0.4),
                hintFontWeight: FontWeight.normal,
                enabledBorderColor: AppColors.white,
                focusedBorderColor: AppColors.white,
                fillColor: AppColors.white.withOpacity(0.05),
                filled: true,
              ),
            ),
            30.h.height,
            Obx(() {
              return widget.portfolioController.isAddLoading.value
                  ? Center(child: CustomActivityIndicator())
                  : CustomButton(
                      height: 50.sp,
                      borderRadius: 10.sp,
                      title: "Add",
                      isGradientEnabled: true,
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        // Validate form fields
                        if (_formKey.currentState!.validate()) {
                          double editedAmount = double.parse(amountController.text);
                          bool isAdded = await widget.portfolioController.addPortfolio(editedAmount);
                          Get.back();

                          if (isAdded) {
                            await widget.portfolioController.fetchPortfolioApi();
                            CustomSnackbar.show(
                              iconData: Icons.check_circle,
                              title: "Add Alert",
                              message: "",
                              backgroundColor: AppColors.white,
                              iconColor: Colors.green,
                              messageTextList: ["Added Successfully"],
                              messageTextColor: Colors.black,
                            );
                          } else {
                            CustomSnackbar.show(
                              iconData: Icons.warning_amber,
                              title: "Add Error",
                              message: "",
                              backgroundColor: AppColors.white,
                              iconColor: AppColors.negativeRed,
                              messageTextList: GlobalVariables.errorMessages,
                              messageTextColor: Colors.black,
                            );
                          }
                        } else {
                          widget.portfolioController.fieldsValidate = true;
                        }
                      },
                    );
            }),
            20.h.height,
          ],
        ).paddingHorizontal(15.w).paddingVertical(15.h),
      ),
    );
  }

  GradientOutlineInputBorder buildOutlineInputBorder({required double borderRadius, required Color color}) {
    return GradientOutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      gradient:
          LinearGradient(colors: [AppColors.white.withOpacity(.2), AppColors.white.withOpacity(.02)], stops: [.3, .8], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      width: 1,
    );
  }
}

class EditAmountDialog extends StatefulWidget {
  final PortfolioController portfolioController;
  final double? editAmount;


  const EditAmountDialog({super.key, required this.portfolioController, this.editAmount});

  @override
  State<EditAmountDialog> createState() => _EditAmountDialogState();
}

class _EditAmountDialogState extends State<EditAmountDialog> {
  final TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    amountController.text = (widget.editAmount ?? 0).toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
        backgroundColor: const Color(0xff0A0B0A),
        shape: buildOutlineInputBorder(
          borderRadius: 21.sp,
          color: AppColors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.close,
                    size: 20.sp,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            Text(
              'Edit Amount',
              style: AppTextStyles.customText24(
                color: AppColors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            30.h.height,
            Form(
              key: _formKey,
              child: CustomField(
                keyboardType: TextInputType.number,
                controller: amountController,
                textInputAction: TextInputAction.done,
                labelColor: AppColors.white,
                labelTextFontSize: 13.sp,
                hintText: 'Amount',
                hintTextFontSize: 14.sp,
                hintColor: Colors.white.withOpacity(0.4),
                hintFontWeight: FontWeight.normal,
                enabledBorderColor: AppColors.white,
                focusedBorderColor: AppColors.white,
                fillColor: AppColors.white.withOpacity(0.05),
                filled: true,
              ),
            ),
            30.h.height,
            Obx(() {
              return widget.portfolioController.isUpdateLoading.value
                  ? Center(child: CustomActivityIndicator())
                  : CustomButton(
                      height: 50.sp,
                      borderRadius: 10.sp,
                      title: "Edit",
                      isGradientEnabled: true,
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        // Validate form fields
                        if (_formKey.currentState!.validate()) {
                          double editedAmount = double.parse(amountController.text);
                          bool isUpdated = await widget.portfolioController.updatePortfolio(editedAmount);
                          Get.back();

                          if (isUpdated) {
                            await widget.portfolioController.fetchPortfolioApi();

                            CustomSnackbar.show(
                              iconData: Icons.check_circle,
                              title: "Update Alert",
                              message: "",
                              backgroundColor: AppColors.white,
                              iconColor: Colors.green,
                              messageTextList: ["Update Successfully"],
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
                        } else {
                          widget.portfolioController.fieldsValidate = true;
                        }
                      },
                    );
            }),
            20.h.height,
          ],
        ).paddingHorizontal(15.w).paddingVertical(15.h),
      ),
    );
  }

  GradientOutlineInputBorder buildOutlineInputBorder({
    required double borderRadius,
    required Color color,
  }) {
    return GradientOutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      gradient: LinearGradient(
        colors: [
          AppColors.white.withOpacity(.2),
          AppColors.white.withOpacity(.02),
        ],
        stops: [.3, .8],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      width: 1,
    );
  }
}

class DeleteDialog extends StatefulWidget {
  final PortfolioController portfolioController;

  const DeleteDialog({super.key, required this.portfolioController});

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
        backgroundColor: const Color(0xff0A0B0A),
        shape: buildOutlineInputBorder(
          borderRadius: 21.sp,
          color: AppColors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.close,
                    size: 20.sp,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            Text(
              'Confirm deletion?',
              textAlign: TextAlign.center,
              style: AppTextStyles.customText24(
                color: AppColors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            30.h.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Obx(() {
                    return widget.portfolioController.isDeleteLoading.value
                        ? Center(child: CustomActivityIndicator())
                        : CustomButton(
                            bgColor: AppColors.negativeRed,
                            height: 50.sp,
                            borderRadius: 10.sp,
                            title: "Yes",
                            isGradientEnabled: false,
                            onPressed: () async {
                              bool? isDeleted = await widget.portfolioController.deletePortfolio();
                              Get.back();

                              if (isDeleted== true) {
                                await widget.portfolioController.fetchPortfolioApi();

                                CustomSnackbar.show(
                                  iconData: Icons.check_circle,
                                  title: "Delete Alert",
                                  message: "",
                                  backgroundColor: AppColors.white,
                                  iconColor: Colors.green,
                                  messageTextList: ["Deleted Successfully"],
                                  messageTextColor: Colors.black,
                                );
                              } else {
                                CustomSnackbar.show(
                                  iconData: Icons.warning_amber,
                                  title: "Delete Error",
                                  message: "",
                                  backgroundColor: AppColors.white,
                                  iconColor: AppColors.negativeRed,
                                  messageTextList: GlobalVariables.errorMessages,
                                  messageTextColor: Colors.black,
                                );
                              }
                              // Close the dialog
                            },
                          );
                  }).paddingOnly(right: 10.w),
                ),
                Expanded(
                  child: CustomButton(
                    height: 50.sp,
                    borderRadius: 10.sp,
                    title: "Cancel",
                    isGradientEnabled: true,
                    onPressed: () {
                      Get.back(); // Close the dialog
                    },
                  ).paddingOnly(right: 10.w),
                ),
              ],
            ),
            20.h.height,
          ],
        ).paddingHorizontal(15.w).paddingVertical(15.h),
      ),
    );
  }

  GradientOutlineInputBorder buildOutlineInputBorder({
    required double borderRadius,
    required Color color,
  }) {
    return GradientOutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      gradient: LinearGradient(
        colors: [
          AppColors.white.withOpacity(.2),
          AppColors.white.withOpacity(.02),
        ],
        stops: [.3, .8],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      width: 1,
    );
  }
}
