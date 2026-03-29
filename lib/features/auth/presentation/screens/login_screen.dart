import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/localization/app_localizations.dart';
import 'package:movies_app/features/auth/presentation/screens/register_screen.dart';
import '../../../../core/widgets/AuthButton.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/localization/locale_bloc.dart';
import '../../../../core/localization/locale_event.dart';
import '../../../../core/localization/locale_state.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login Success!'), backgroundColor: Colors.green),
                );
              } else if (state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
                );
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Image.asset('assets/images/Splash_Screen.png', width: 200.w, height: 200.h, fit: BoxFit.contain),
                  SizedBox(height: 10.h),
                  AppTextFormField(
                    controller: emailController,
                    hintText: 'Email'.tr(context),
                    prefixWidget: Image.asset('assets/images/email.png', color: Colors.white, height: 20.h),
                  ),
                  SizedBox(height: 16.h),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      bool isObscure = context.read<AuthBloc>().isPasswordObscure;
                      return AppTextFormField(
                        controller: passwordController,
                        hintText: 'Password'.tr(context),
                        isObscureText: isObscure,
                        prefixWidget: Image.asset('assets/images/password.png', color: Colors.white, height: 20.h),
                        suffixWidget: GestureDetector(
                          onTap: () => context.read<AuthBloc>().add(TogglePasswordVisibilityEvent()),
                          child: Icon(
                              isObscure ? Icons.visibility_off : Icons.visibility,
                              color: Colors.white,
                              size: 20.sp
                          ),
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordScreen())),
                      child: Text(
                        'Forget Password?'.tr(context),
                        style: TextStyle(color: const Color(0xFFFFC107), fontSize: 13.sp),
                      ),
                    ),
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoadingState) return const CircularProgressIndicator(color: Color(0xFFFFC107));
                      return AuthButton(
                        text: 'Login'.tr(context),
                        onPressed: () {
                          if (isValidEmail(emailController.text)) {
                            context.read<AuthBloc>().add(LoginSubmittedEvent(email: emailController.text, password: passwordController.text));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid Email'), backgroundColor: Colors.red));
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't Have Account? ".tr(context), style: TextStyle(color: Colors.white, fontSize: 13.sp)),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen())),
                        child: Text("Create One".tr(context), style: TextStyle(color: const Color(0xFFFFC107), fontWeight: FontWeight.bold, fontSize: 13.sp)),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Expanded(child: Divider(color: const Color(0xFFFFC107), thickness: 1)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text("OR".tr(context), style: TextStyle(color: const Color(0xFFFFC107), fontWeight: FontWeight.bold)),
                        ),
                        Expanded(child: Divider(color: const Color(0xFFFFC107), thickness: 1)),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  AuthButton(
                      text: 'Login With Google'.tr(context),
                      icon: Image.asset('assets/images/🦆 icon _google_.png', height: 22.h),
                      onPressed: () {
                        context.read<AuthBloc>().add(GoogleLoginEvent());
                      }
                  ),
                  SizedBox(height: 30.h),
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

  Widget _buildFlagOption(String imagePath, {required bool isSelected}) {
    return Container(
      padding: EdgeInsets.all(2.r),
      decoration: isSelected ? const BoxDecoration(color: Color(0xFFFFC107), shape: BoxShape.circle) : null,
      child: ClipOval(child: Image.asset(imagePath, width: 26.w, height: 26.h, fit: BoxFit.cover)),
    );
  }
}