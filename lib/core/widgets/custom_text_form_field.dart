import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

typedef OnValidator = String? Function(String?)?;

class CustomTextFormField extends StatelessWidget {
  final Color? colorBorderSide;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final OnValidator validator;
  final TextEditingController? controller;
  final TextInputType keyBoardType;
  final bool obscureText;
  final int? maxLines;
  final Function(String)? onChanged;

  const CustomTextFormField({
    super.key,
    required this.colorBorderSide,
    this.hintText,
    this.hintStyle,
    this.labelStyle,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.maxLines,
    this.controller,
    this.keyBoardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Theme.of(context).canvasColor),
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        enabledBorder: buildDecorationBorder(colorBorderSide: colorBorderSide),
        focusedBorder: buildDecorationBorder(colorBorderSide: colorBorderSide),
        errorBorder: buildDecorationBorder(colorBorderSide: AppColors.redColor),
        focusedErrorBorder: buildDecorationBorder(
          colorBorderSide: AppColors.redColor,
        ),
        errorStyle: AppStyles.regular16White.copyWith(
          color: AppColors.redColor,
        ),
        hintText: hintText,
        hintStyle: hintStyle ?? AppStyles.regular16White,
        labelText: labelText,
        labelStyle: labelStyle ?? AppStyles.regular16White,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      controller: controller,
      keyboardType: keyBoardType,
      obscureText: obscureText,
      onChanged: onChanged,
    );
  }

  OutlineInputBorder buildDecorationBorder({required Color? colorBorderSide}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: colorBorderSide!, width: 1),
    );
  }
}
