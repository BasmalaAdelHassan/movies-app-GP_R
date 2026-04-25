import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'firebase_options.dart';
import 'core/localization/app_localizations.dart';
import 'core/localization/locale_bloc.dart';
import 'core/localization/locale_state.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';
import 'home/browse_tab.dart';
import 'home/home_screen.dart';
import 'home/home_tab.dart';
import 'home/movie_details_screen.dart';
import 'home/profile_tab.dart';
import 'home/search_tab.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => LocaleBloc()),
      ],
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Movies App',
                locale: state.locale,
                supportedLocales: const [Locale('en'), Locale('ar')],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                theme: ThemeData(
                  brightness: Brightness.dark,
                  scaffoldBackgroundColor: Colors.black,
                  primaryColor: const Color(0xFFFFC107),
                ),
                initialRoute: AppRoutes.onboardingScreen,
                routes: {
                  AppRoutes.onboardingScreen: (context) => OnboardingScreen(),
                  AppRoutes.homeScreenRouteName: (context) => HomeScreen(),
                  AppRoutes.homeTabRouteName: (context) => HomeTab(),
                  AppRoutes.searchTabRouteName: (context) => SearchTab(),
                  AppRoutes.browseTabRouteName: (context) => BrowseTab(),
                  AppRoutes.profileTabScreen: (context) => ProfileTab(),
                  AppRoutes.movieDetailsScreen: (context) =>
                      MovieDetailsScreen(),
                },
              );
            },
          );
        },
      ),
    );
  }
}
