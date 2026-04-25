import 'package:flutter/material.dart';
import 'package:movies_app/api/api_movie_details_screen.dart';
import 'package:movies_app/api/api_similar.dart';
import 'package:movies_app/utils/app_colors.dart';



import '../core/widgets/custom_box.dart';
import '../core/widgets/custom_elevated_button.dart';
import '../models/movie_details_response.dart';
import '../utils/app_assets.dart';

import '../utils/app_styles.dart';


class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
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
    final movieId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<MovieDetailsResponse?>(
              future: ApiMovieDetailsScreen.getMovieDetails(movieId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    heightFactor: 22,
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Image.asset(AppAssets.emptyListIcon));
                }

                var movie = snapshot.data!.data!.movie!;
                var movieCast = snapshot.data!.data!.movie!.cast ?? [];
                var movieGenres = snapshot.data!.data!.movie!.genres ?? [];

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.55,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Opacity(
                              opacity: 0.5,
                              child: buildNetworkImage(
                                movie.largeCoverImage!,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Center(child: Image.asset(AppAssets.playIcon)),
                            Positioned(
                              top: 50,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.025,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Image.asset(
                                        AppAssets.arrowBackIcon,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.8),
                                  Icon(
                                    Icons.bookmark,
                                    size: 35,
                                    color: AppColors.whiteColor,
                                  ),
                                ],
                              ),
                            ),
                            Positioned.fill(
                              top: 400,
                              child: Center(
                                child: Text(
                                  movie.title ?? "",
                                  style: AppStyles.robotoBold24White,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Positioned.fill(
                              top: 465,
                              child: Center(
                                child: Text(
                                  movie.year.toString(),
                                  style: AppStyles.robotoBold20White.copyWith(
                                    color: AppColors.vLightGreyColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.025,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: CustomElevatedButton(
                            onPressed: () {},
                            text: 'Watch',
                            backgroundColor: AppColors.redColor,
                            textStyle: AppStyles.regular20White.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.025,
                        ),
                        child: Row(
                          children: [
                            CustomBox(
                              image: AppAssets.favoriteIcon,
                              text: movie.likeCount.toString(),
                            ),
                            SizedBox(width: width * 0.03),
                            CustomBox(
                              image: AppAssets.timeIcon,
                              text: movie.runtime.toString(),
                            ),
                            SizedBox(width: width * 0.03),
                            CustomBox(
                              image: AppAssets.starIcon,
                              text: movie.rating.toString(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.015,
                        ),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Screen Shots',
                            style: AppStyles.robotoBold24White,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.015,
                        ),
                        child: SizedBox(
                          height: height * 0.24,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            clipBehavior: Clip.antiAlias,
                            child: buildNetworkImage(
                              movie.largeScreenshotImage1,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.015,
                        ),
                        child: SizedBox(
                          height: height * 0.24,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            clipBehavior: Clip.antiAlias,
                            child: buildNetworkImage(
                              movie.largeScreenshotImage2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.015,
                        ),
                        child: SizedBox(
                          height: height * 0.24,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            clipBehavior: Clip.antiAlias,
                            child: buildNetworkImage(
                              movie.largeScreenshotImage3,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.015,
                        ),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Similar',
                            style: AppStyles.robotoBold24White,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.015,
                        ),
                        child: FutureBuilder(
                          future: ApiSimilar.getMovieSuggestion(movieId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                heightFactor: 22,
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text("Error: ${snapshot.error}"),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data == null) {
                              return Center(
                                child: Image.asset(AppAssets.emptyListIcon),
                              );
                            }
                            var movie = snapshot.data!.data!.movies!;
                            return SizedBox(
                              height: height * 0.45,
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: movie.length,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 6,
                                  crossAxisCount: 2,
                                ),
                                itemBuilder: (context, index) {
                                  final movies = movie[index];
                                  return Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    margin: EdgeInsets.all(4),
                                    child: Stack(
                                      fit: StackFit.passthrough,
                                      alignment: Alignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          child: buildNetworkImage(
                                            movies.mediumCoverImage ?? "",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          left: 8,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.blackColor
                                                  .withValues(alpha: 0.7),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  movies.rating?.toString() ??
                                                      "N/A",
                                                  style: TextStyle(
                                                    color: AppColors.whiteColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 4),
                                                Icon(
                                                  Icons.star,
                                                  color: AppColors.yellowColor,
                                                  size: 14,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.015,
                        ),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Summary',
                            style: AppStyles.robotoBold24White,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.025,
                        ),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            movie.titleLong ?? '',
                            style: AppStyles.robotoRegular16White,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.025,
                        ),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Cast',
                            style: AppStyles.robotoBold24White,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.025,
                        ),
                        child: SizedBox(
                          height: 380,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: false,
                            itemCount: movieCast.length,
                            itemBuilder: (BuildContext context, int index) {
                              final actor = movieCast[index];
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 6),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.lightGreyColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: buildNetworkImage(
                                        actor.urlSmallImage ?? '',
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Name : ${actor.name ?? 'Unknown'}",
                                            style: AppStyles.robotoBold20White,
                                          ),
                                          Text(
                                            "Character : ${actor.characterName ?? 'Unknown'}",
                                            style: AppStyles.robotoBold20White,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.015,
                        ),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Genres',
                            style: AppStyles.robotoBold24White,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.025),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.025,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.zero,
                            itemCount: movieGenres.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(width: width * 0.05);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              final movieCategory = movieGenres[index];
                              return Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(12),
                                width: 100,
                                height: height * 0.05,
                                decoration: BoxDecoration(
                                  color: AppColors.darkGreyColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  movieCategory,
                                  style: AppStyles.robotoRegular16White,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
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
