import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../logic/onboarding_bloc.dart';
import '../../logic/onboarding_event.dart';
import '../../logic/onboarding_state.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/onboarding_card.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> onboardingData = [
    {
      "image": "assets/images/the_first_onboarding.png",
      "title": "Find Your Next Favorite Movie Here",
      "desc": "Get access to a huge library of movies to suit all tastes. You will surely like it.",
      "gradient_color": Colors.black,
    },
    {
      "image": "assets/images/the_second_onboarding.png",
      "title": "Discover Movies",
      "desc": "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
      "gradient_color": const Color(0xFF084250),
    },
    {
      "image": "assets/images/the_third_onboarding.png",
      "title": "Explore All Genres",
      "desc": "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
      "gradient_color": const Color(0xFF85210E),
    },
    {
      "image": "assets/images/the_four_onboarding.png",
      "title": "Create Watchlists",
      "desc": "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
      "gradient_color": const Color(0xFF4C2471),
    },
    {
      "image": "assets/images/the_five_onboarding.png",
      "title": "Rate, Review, and Learn",
      "desc": "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies.",
      "gradient_color": const Color(0xFF601321),
    },
    {
      "image": "assets/images/the_six_onboarding.png",
      "title": "Start Watching Now",
      "desc": "",
      "gradient_color": const Color(0xFF2A2C30),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: BlocProvider(
        create: (context) => OnboardingBloc(),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              final currentPageData = onboardingData[state.currentIndex];

              return Stack(
                children: [
                  Positioned.fill(
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          height: state.currentIndex == 0 ? 1.sh : 0.7.sh,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            child: Transform.scale(
                              key: ValueKey<int>(state.currentIndex),
                              scale: state.currentIndex == 0 ? 2.8 : 1.1,
                              child: Image.asset(
                                currentPageData['image']!,
                                fit: BoxFit.cover,
                                color: state.currentIndex == 0
                                    ? Colors.black.withOpacity(0.0)
                                    : Colors.black.withOpacity(0.3),
                                colorBlendMode: BlendMode.darken,
                              ),
                            ),
                          ),
                        ),
                        if (state.currentIndex > 0)
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            height: 120.h,
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.black, Colors.transparent],
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: state.currentIndex == 0 ? 1.sh : 0.45.sh,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.0, 0.3, 1.0],
                                colors: [
                                  Colors.transparent,
                                  currentPageData['gradient_color'].withOpacity(0.8),
                                  currentPageData['gradient_color'],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: onboardingData.length,
                      onPageChanged: (index) {
                        context.read<OnboardingBloc>().add(PageChangedEvent(index));
                      },
                      itemBuilder: (context, index) => const SizedBox.expand(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: state.currentIndex == 0
                        ? Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            currentPageData['title']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            currentPageData['desc']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 30.h),
                          MainButton(
                            text: "Explore Now",
                            onPressed: () => _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            ),
                          ),
                        ],
                      ),
                    )
                        : OnboardingCard(
                      title: currentPageData['title']!,
                      description: currentPageData['desc']!,
                      currentIndex: state.currentIndex,
                      totalPages: onboardingData.length,
                      controller: _pageController,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}