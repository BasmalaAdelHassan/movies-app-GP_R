import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../../onboarding/presentation/screens/onboarding_screen.dart';

class SplashScreenHandler extends StatefulWidget {
  const SplashScreenHandler({super.key});

  @override
  State<SplashScreenHandler> createState() => _SplashScreenHandlerState();
}

class _SplashScreenHandlerState extends State<SplashScreenHandler> {
  @override
  void initState() {
    super.initState();
    _startNextScreen();
  }

  void _startNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    FlutterNativeSplash.remove();

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF121312),
    );
  }
}