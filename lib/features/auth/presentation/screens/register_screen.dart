import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/AuthButton.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/localization/locale_bloc.dart';
import '../../../../core/localization/locale_event.dart';
import '../../../../core/localization/locale_state.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../../../core/localization/app_localizations.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFFC107)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Register".tr(context),
          style: TextStyle(
            color: const Color(0xFFFFC107),
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccessState) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Account Created Successfully".tr(context))),
                );
              }
              if (state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildAvatar('assets/images/gamer (1).png', 80),
                      SizedBox(width: 10.w),
                      _buildAvatar('assets/images/gamer (2).png', 130, hasBorder: true),
                      SizedBox(width: 10.w),
                      _buildAvatar('assets/images/gamer (3).png', 80),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Avatar".tr(context),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  AppTextFormField(
                    controller: nameController,
                    hintText: 'Name'.tr(context),
                    prefixWidget: Image.asset('assets/images/🦆 icon _Identification_.png', height: 20.h, color: Colors.white),
                  ),
                  SizedBox(height: 16.h),
                  AppTextFormField(
                    controller: emailController,
                    hintText: 'Email'.tr(context),
                    prefixWidget: Image.asset('assets/images/email.png', height: 20.h, color: Colors.white),
                  ),
                  SizedBox(height: 16.h),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      bool isObscure = context.read<AuthBloc>().isPasswordObscure;
                      return Column(
                        children: [
                          AppTextFormField(
                            controller: passwordController,
                            hintText: 'Password'.tr(context),
                            isObscureText: isObscure,
                            prefixWidget: const Icon(Icons.lock, color: Colors.white),
                            suffixWidget: GestureDetector(
                              onTap: () => context.read<AuthBloc>().add(TogglePasswordVisibilityEvent()),
                              child: Icon(isObscure ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          AppTextFormField(
                            controller: confirmPasswordController,
                            hintText: 'Confirm Password'.tr(context),
                            isObscureText: isObscure,
                            prefixWidget: const Icon(Icons.lock, color: Colors.white),
                            suffixWidget: GestureDetector(
                              onTap: () => context.read<AuthBloc>().add(TogglePasswordVisibilityEvent()),
                              child: Icon(isObscure ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                  AppTextFormField(
                    controller: phoneController,
                    hintText: 'Phone Number'.tr(context),
                    prefixWidget: Image.asset('assets/images/phone.png', height: 20.h, color: Colors.white),
                  ),
                  SizedBox(height: 30.h),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return const Center(child: CircularProgressIndicator(color: Color(0xFFFFC107)));
                      }
                      return AuthButton(
                        text: 'Create Account'.tr(context),
                        onPressed: () {
                          context.read<AuthBloc>().add(
                            RegisterSubmittedEvent(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                              avatar: 'assets/images/gamer (2).png',
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFF212121),
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(color: const Color(0xFFFFC107), width: 1.5),
                    ),
                    child: BlocBuilder<LocaleBloc, LocaleState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () => context.read<LocaleBloc>().add(ChangeLocaleEvent('en')),
                              child: _buildFlagOption('assets/images/LR.png', isSelected: state.locale.languageCode == 'en'),
                            ),
                            SizedBox(width: 15.w),
                            GestureDetector(
                              onTap: () => context.read<LocaleBloc>().add(ChangeLocaleEvent('ar')),
                              child: _buildFlagOption('assets/images/EG.png', isSelected: state.locale.languageCode == 'ar'),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(String path, double size, {bool hasBorder = false}) {
    return Container(
      decoration: hasBorder ? BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFFFC107), width: 2)) : null,
      child: ClipOval(child: Image.asset(path, width: size.w, height: size.h, fit: BoxFit.cover)),
    );
  }

  Widget _buildFlagOption(String imagePath, {required bool isSelected}) {
    return Container(
      padding: EdgeInsets.all(2.r),
      decoration: isSelected ? const BoxDecoration(color: Color(0xFFFFC107), shape: BoxShape.circle) : null,
      child: ClipOval(child: Image.asset(imagePath, width: 26.88.w, height: 26.88.h, fit: BoxFit.cover)),
    );
  }
}