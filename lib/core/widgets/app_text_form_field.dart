import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatelessWidget {
  final String hintText;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final bool isObscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const AppTextFormField({
    super.key,
    required this.hintText,
    this.prefixWidget,
    this.suffixWidget,
    this.isObscureText = false,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscureText,
      validator: validator,
      style: TextStyle(color: Colors.white, fontSize: 16.sp),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
        prefixIconConstraints: BoxConstraints(
          minWidth: 40.w,
          maxHeight: 24.h,
        ),
        prefixIcon: prefixWidget != null ? Padding(
          padding: EdgeInsets.only(left: 12.w, right: 8.w),
          child: prefixWidget,
        ) : null,
        suffixIconConstraints: BoxConstraints(
          minWidth: 40.w,
          maxHeight: 24.h,
        ),
        suffixIcon: suffixWidget != null ? Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: suffixWidget,
        ) : null,
        fillColor: const Color(0xFF212121),
        filled: true,
        border: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(color: const Color(0xFFFFC107)),
        errorBorder: buildOutlineInputBorder(color: Colors.red),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: color != null
          ? BorderSide(color: color, width: 1.3)
          : BorderSide.none,
    );
  }
}