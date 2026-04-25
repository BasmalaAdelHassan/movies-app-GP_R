import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';



class CustomElevatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Color? borderColor;
  final bool icon;
  final Widget? iconWidget;
  final MainAxisAlignment? mainAxisAlignment;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = AppColors.yellowColor,
    this.textStyle,
    this.borderColor,
    this.icon = false,
    this.iconWidget,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: widget.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: widget.borderColor ?? AppColors.transparentColor,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: height * 0.02),
      ),
      onPressed: widget.onPressed,
      child: widget.icon
          ? Row(
        mainAxisAlignment: widget.mainAxisAlignment!,
        children: [
          widget.iconWidget!,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Text(
              widget.text,
              style: widget.textStyle ?? AppStyles.regular20Black,
            ),
          ),
        ],
      )
          : Text(
        widget.text,
        style: widget.textStyle ?? AppStyles.regular20Black,
      ),
    );
  }
}
