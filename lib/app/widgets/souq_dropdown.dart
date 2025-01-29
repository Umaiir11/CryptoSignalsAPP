import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:souq_ai/app/config/app_colors.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import 'package:souq_ai/app/widgets/blur_container.dart';

import '../mvvm/model/response_model/crypto_symbols.dart';

class SouqDropdownWidget<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedValue;
  final String hintText;
  final ValueChanged<T?> onChanged;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;

  const SouqDropdownWidget({
    Key? key,
    required this.items,
    required this.selectedValue,
    required this.hintText,
    required this.onChanged,
    this.textStyle,
    this.hintTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      height: 52.h,
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: selectedValue,
          hint: Text(
            hintText,
            style: hintTextStyle ??
                TextStyle(fontSize: 16.sp, color: Colors.white.withOpacity(0.3)),
          ),
          dropdownColor: AppColors.primary,
          borderRadius: BorderRadius.circular(10.sp),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          isExpanded: true,
          onChanged: onChanged,
          items: items.map((T value) {
            if (value is CurrencySymbols) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(
                  value.symbol ?? '', // Display the symbol
                  style: textStyle ?? const TextStyle(color: Colors.white),
                ),
              );
            }
            return DropdownMenuItem<T>(
              value: value,
              child: Text(
                value.toString(),
                style: textStyle ?? const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
        ),
      ).paddingHorizontal(16.w),
    );
  }
}

class SouqSymbolDropdownWidget<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedValue;
  final String hintText;
  final ValueChanged<T?> onChanged;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;

  const SouqSymbolDropdownWidget({
    Key? key,
    required this.items,
    required this.selectedValue,
    required this.hintText,
    required this.onChanged,
    this.textStyle,
    this.hintTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurContainer(
      height: 52.h,
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: items.contains(selectedValue) ? selectedValue : null,
          hint: Text(
            hintText,
            style: hintTextStyle ??
                TextStyle(fontSize: 16.sp, color: Colors.white.withOpacity(0.3)),
          ),
          dropdownColor: AppColors.primary,
          borderRadius: BorderRadius.circular(10.sp),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          isExpanded: true,
          onChanged: onChanged,
          items: items.map((T value) {
            if (value is CurrencySymbols) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(
                  value.symbol ?? '', // Display the symbol
                  style: textStyle ?? const TextStyle(color: Colors.white),
                ),
              );
            }
            return DropdownMenuItem<T>(
              value: value,
              child: Text(
                value.toString(),
                style: textStyle ?? const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
        ),
      ).paddingHorizontal(16.w),
    );
  }
}
