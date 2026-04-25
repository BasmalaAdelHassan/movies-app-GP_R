import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

import '../api/api_home_tab.dart';
import '../models/movie_response.dart';
import '../utils/app_assets.dart';
import '../utils/app_routes.dart';
import '../utils/app_styles.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;
  late Future<Movie?> moviesFuture;

  @override
  void initState() {
    moviesFuture = ApiHomeTab.getMovies();
    super.initState();
  }

  Widget buildNetworkImage(
    String? url, {
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
  }) {
    return Image.network(
      url ?? "https://via.placeholder.com/300",
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          AppAssets.emptyListIcon,
          fit: fit,
          width: width,
          height: height,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<Movie?>(
              future: moviesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    heightFactor: 22,
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.data?.data?.movies == null) {
                  return Center(child: Image.asset(AppAssets.emptyListIcon));
                }

                var movies = snapshot.data?.data?.movies ?? [];

                return SizedBox(
                  height: height * 0.75,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 600),
                          child: buildNetworkImage(
                            movies[currentIndex].mediumCoverImage,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                AppColors.darkGreyColor,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(color: Colors.black.withAlpha(153)),
                      ),
                      Positioned(
                        top: 50,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Image.asset(AppAssets.availableNowImage),
                        ),
                      ),
                      Center(
                        child: CarouselSlider.builder(
                          itemCount: movies.length,
                          itemBuilder: (context, index, realIndex) {
                            final movie = movies[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.movieDetailsScreen,
                                  arguments: movie.id,
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: buildNetworkImage(
                                        movie.mediumCoverImage,
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      left: 8,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withAlpha(178),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              movie.rating?.toString() ?? "N/A",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            const Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 14,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height: height * 0.4,
                            enlargeCenterPage: true,
                            viewportFraction: 0.6,
                            onPageChanged: (index, reason) {
                              setState(() => currentIndex = index);
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -22,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Image.asset(AppAssets.watchNowImage),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: height * 0.02),
            FutureBuilder<Movie?>(
              future: moviesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text(''));
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.data?.data?.movies == null) {
                  return Center(child: Image.asset(AppAssets.emptyListIcon));
                }

                var movies = snapshot.data?.data?.movies ?? [];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Action', style: AppStyles.regular20White),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.browseTabRouteName,
                              );
                            },
                            child: Text(
                              'See More',
                              style: AppStyles.regular16Yellow,
                            ),
                          ),
                          Icon(Icons.arrow_right, color: AppColors.yellowColor),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      SizedBox(
                        height: 200,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.movieDetailsScreen,
                                  arguments: movie.id,
                                );
                              },
                              child: Container(
                                width: 130,
                                margin: const EdgeInsets.only(right: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: buildNetworkImage(
                                    movie.mediumCoverImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(width: width * 0.02);
                          },
                          itemCount: movies.length,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
