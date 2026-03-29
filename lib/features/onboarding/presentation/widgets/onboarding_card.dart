import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../auth/presentation/screens/login_screen.dart';

class OnboardingCard extends StatelessWidget {
  final String title;
  final String description;
  final int currentIndex;
  final int totalPages;
  final PageController controller;

  const OnboardingCard({
    super.key,
    required this.title,
    required this.description,
    required this.currentIndex,
    required this.totalPages,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 26.h, 16.w, 26.h),
      decoration: BoxDecoration(
        color: const Color(0xFF121312),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.r),
          topRight: Radius.circular(40.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              height: 1.0,
              letterSpacing: 0,
            ),
          ),
          if (description.isNotEmpty) SizedBox(height: 12.h),
          if (description.isNotEmpty)
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                height: 1.0,
                letterSpacing: 0,
              ),
            ),
          SizedBox(height: 16.h),
          MainButton(
            text: currentIndex == totalPages - 1 ? "Finish" : "Next",
            onPressed: () {
              if (currentIndex < totalPages - 1) {
                controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              }
            },
          ),
          if (currentIndex > 1) ...[
            SizedBox(height: 12.h),
            CustomOutlinedButton(
              text: "Back",
              onPressed: () {
                controller.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}