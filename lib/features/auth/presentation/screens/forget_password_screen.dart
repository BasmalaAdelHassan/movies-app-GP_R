import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/AuthButton.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../../../core/localization/app_localizations.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  bool isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

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
          "Forget Password".tr(context),
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Password reset link sent to your email!'.tr(context)),
                    backgroundColor: Colors.green,
                  ),
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
                  Image.asset(
                    'assets/images/Forgot password-bro 1.png',
                    width: 430.w,
                    height: 430.h,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 392.w,
                    height: 56.h,
                    child: AppTextFormField(
                      controller: emailController,
                      hintText: 'Email'.tr(context),
                      prefixWidget: Image.asset(
                        'assets/images/email.png',
                        color: Colors.white,
                        height: 20.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return const CircularProgressIndicator(color: Color(0xFFFFC107));
                      }
                      return AuthButton(
                        text: 'Verify Email'.tr(context),
                        onPressed: () {
                          String email = emailController.text.trim();
                          if (email.isEmpty || !isValidEmail(email)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please enter a valid email to reset password'.tr(context)),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            context.read<AuthBloc>().add(ForgotPasswordEvent(email));
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}