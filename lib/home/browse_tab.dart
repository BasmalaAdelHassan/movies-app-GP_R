import 'package:flutter/material.dart';
import 'package:movies_app/api/api_home_tab.dart';

import '../models/movie_response.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';
import '../utils/app_styles.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<BrowseTab> {
  int currentIndex = 0;
  late Future<Movie?> moviesFuture;

  final List<String> category = [
    "Action",
    "Adventure",
    "Animation",
    "Biography",
  ];

  @override
  void initState() {
    moviesFuture = ApiHomeTab.getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: category.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 20,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.blackColor,
          bottom: TabBar(
            labelPadding: const EdgeInsets.all(6),
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            dividerColor: AppColors.transparentColor,
            padding: EdgeInsets.zero,
            indicatorColor: AppColors.transparentColor,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            tabs: List.generate(
              category.length,
              (index) => tabBarContainer(category[index], index),
            ),
          ),
        ),
        backgroundColor: AppColors.blackColor,
        body: FutureBuilder<Movie?>(
          future: moviesFuture,
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

            var movies = snapshot.data!.data!.movies ?? [];

            var filteredMovies = movies.where((movie) {
              final movieGenres = movie.genres ?? [];
              return movieGenres.contains(category[currentIndex]);
            }).toList();

            if (filteredMovies.isEmpty) {
              return Center(
                child: Text(
                  "No ${category[currentIndex]} movies found",
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            return Container(
              margin: const EdgeInsets.only(top: 12),
              width: double.infinity,
              height: height * 0.80,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final movie = filteredMovies[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.movieDetailsScreen,
                        arguments: movie.id,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      child: Stack(
                        fit: StackFit.passthrough,
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              movie.mediumCoverImage ?? "",
                              fit: BoxFit.fill,
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
                                borderRadius: BorderRadius.circular(8),
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
                itemCount: filteredMovies.length,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget tabBarContainer(String text, int selectedIndex) {
    bool isSelected = currentIndex == selectedIndex;

    return Container(
      width: 100,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.yellowColor : AppColors.transparentColor,
        borderRadius: BorderRadius.circular(16),
        border: isSelected
            ? null
            : Border.all(width: 2, color: AppColors.yellowColor),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: isSelected
            ? AppStyles.regular16Black.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              )
            : AppStyles.regular14Yellow.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
      ),
    );
  }
}
