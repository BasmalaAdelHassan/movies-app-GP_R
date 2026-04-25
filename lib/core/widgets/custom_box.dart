import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';


class CustomBox extends StatelessWidget {
  final String image;
  final String text;

  const CustomBox({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 1),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 8),
            height: height * 0.075,
            width: width * 0.29,
            decoration: BoxDecoration(
              color: AppColors.darkGreyColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                SizedBox(width: width * 0.04),
                Image.asset(image),
                SizedBox(width: width * 0.015),
                Text(
                  text,
                  style: AppStyles.regular20White.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
