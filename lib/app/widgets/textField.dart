import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/input_borders/gradient_outline_input_border.dart';
import 'package:souq_ai/app/config/padding_extenstions.dart';
import '../config/app_colors.dart';
import '../config/app_text_style.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    this.hintText,
    this.controller,
    this.maxLines,
    this.minLines,
    this.fieldsTextAlign,
    this.fieldsInputType,
    this.hintFontWeight,
    this.hintColor,
    this.hintTextOverflow,
    this.isReadOnly,
    this.hintTextFontFamily,
    this.hintTextFontSize,
    this.contentPadding,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.errorBorderColor,
    this.disabledBorderColor,
    this.focusErrorBorderColor,
    this.obscureText = false,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.initialValue,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconColor,
    this.suffixIconColor,
    this.onChanged,
    this.onPressed,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
    this.disabledBorder,
    this.focusErrorBorder,
    this.labelText,
    this.labelColor,
    this.labelFontWeight,
    this.labelTextOverflow,
    this.labelTextFontFamily,
    this.labelTextFontSize,
    this.filled,
    this.fillColor,
    this.textColor,
    this.validationText,
    this.labelTitle,
    this.titleWidget,
    this.isRequired = false,
    this.keyboardType,
    this.enabled = true,
    this.onTap, // Add onTap to trigger when the field is tapped
  });

  final String? validationText;
  final String? hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;
  final TextAlign? fieldsTextAlign;
  final TextInputType? fieldsInputType;
  final bool? obscureText;
  final FontWeight? hintFontWeight;
  final Color? hintColor;
  final bool? isReadOnly; // Check if the field is read-only
  final TextOverflow? hintTextOverflow;
  final String? hintTextFontFamily;
  final double? hintTextFontSize;
  final String? labelText;
  final Color? labelColor;
  final FontWeight? labelFontWeight;
  final TextOverflow? labelTextOverflow;
  final TextInputType? keyboardType;
  final String? labelTextFontFamily;
  final double? labelTextFontSize;
  final EdgeInsets? contentPadding;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final Color? errorBorderColor;
  final Color? disabledBorderColor;
  final Color? focusErrorBorderColor;
  final double? focusedBorder;
  final double? enabledBorder;
  final double? errorBorder;
  final double? disabledBorder;
  final double? focusErrorBorder;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final Widget? titleWidget;
  final Widget? suffixIcon;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final Function(String)? onChanged;
  final VoidCallback? onPressed;
  final bool? filled;
  final Color? fillColor;
  final Color? textColor;
  final String? labelTitle;
  final bool isRequired;
  final bool enabled;
  final VoidCallback? onTap; // New onTap callback for custom action

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelTitle != null)
          Row(
            children: [
              Text(
                labelTitle ?? '',
                style: AppTextStyles.customText14(
                  color: labelColor ?? Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (isRequired)
                Text(
                  '*',
                  style: AppTextStyles.customText15(
                    color: AppColors.secondary,
                  ),
                ),
            ],
          ),
        if (titleWidget != null) titleWidget!,
        if (titleWidget != null || labelTitle != null) 8.h.height,
        TextFormField(
          enabled: enabled,
          validator: (value) {
            if (validator != null) {
              return validator!(value);
            } else if (value == null || value.isEmpty) {
              return validationText ?? 'This field cannot be empty';
            }
            return null;
          },
          style: AppTextStyles.customText16(
            color: textColor ?? AppColors.white,
          ),
          initialValue: initialValue,
          textAlign: fieldsTextAlign ?? TextAlign.start,
          maxLines: maxLines ?? 1,
          controller: controller,
          minLines: minLines ?? 1,
          readOnly: isReadOnly ?? false, // Make field read-only based on isReadOnly property
          keyboardType: keyboardType,
          obscureText: obscureText ?? false,
          obscuringCharacter: "•",
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          textInputAction: textInputAction ?? TextInputAction.next,
          onTap: onTap, // Trigger onTap action when field is tapped
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.customText(
              fontSize: hintTextFontSize ?? 12.sp,
              fontWeight: hintFontWeight ?? FontWeight.normal,
              color: hintColor ?? AppColors.white.withOpacity(0.7),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            floatingLabelStyle: const TextStyle(color: Colors.grey),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            filled: filled ?? false,
            fillColor: fillColor,
            border:  OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 3.w,
                style: BorderStyle.solid,
              ),
            ),
            prefixIconColor: prefixIconColor,
            suffixIconColor: suffixIconColor,
            contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
            focusedBorder: buildOutlineInputBorder(
              color: focusedBorderColor ?? AppColors.primary,
              borderRadius: focusedBorder ?? 10.sp,
            ),
            enabledBorder: buildOutlineInputBorder(
              borderRadius: enabledBorder ?? 10.sp,
              color: enabledBorderColor ?? AppColors.black.withOpacity(.3),
            ),
            errorBorder: buildOutlineInputBorder(
              borderRadius: errorBorder ?? 10.sp,
              color: errorBorderColor ?? Colors.red,
            ),
            disabledBorder: buildOutlineInputBorder(
              borderRadius: disabledBorder ?? 10.sp,
              color: disabledBorderColor ?? AppColors.black.withOpacity(.6),
            ),
            focusedErrorBorder: buildOutlineInputBorder(
              borderRadius: focusedBorder ?? 10.sp,
              color: errorBorderColor ?? Colors.red,
            ),
            errorMaxLines: 2,
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }

  GradientOutlineInputBorder buildOutlineInputBorder({required double borderRadius, required Color color}) {
    return GradientOutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),

      gradient: LinearGradient(colors:
      [
        AppColors.white.withOpacity(.2),  AppColors.white.withOpacity(.02)
      ],
          stops: [.3, .8],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
      ),
      width: 1,
    );
  }
}
