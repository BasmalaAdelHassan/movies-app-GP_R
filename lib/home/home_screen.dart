import 'package:flutter/material.dart';
import 'package:movies_app/home/browse_tab.dart';
import 'package:movies_app/home/profile_tab.dart';
import 'package:movies_app/home/search_tab.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import 'home_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [HomeTab(), SearchTab(), BrowseTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          tabs[selectedIndex],
          Positioned(
            left: width * 0.04,
            right: width * 0.04,
            bottom: height * 0.02,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: SizedBox(
                height: 65,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  iconSize: 30,
                  selectedFontSize: 0,
                  unselectedFontSize: 0,
                  elevation: 0,
                  backgroundColor: AppColors.darkGreyColor,
                  currentIndex: selectedIndex,
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  selectedItemColor: AppColors.yellowColor,
                  unselectedItemColor: AppColors.whiteColor,
                  items: [
                    buildBottomNavigationBarItem(
                      index: 0,
                      selectedIconName: AppAssets.homeIconSelected,
                      unSelectedIconName: AppAssets.homeIconUnSelected,
                    ),
                    buildBottomNavigationBarItem(
                      index: 1,
                      selectedIconName: AppAssets.searchIconSelected,
                      unSelectedIconName: AppAssets.searchIconUnSelected,
                    ),
                    buildBottomNavigationBarItem(
                      index: 2,
                      selectedIconName: AppAssets.browseIconSelected,
                      unSelectedIconName: AppAssets.browseIconUnSelected,
                    ),
                    buildBottomNavigationBarItem(
                      index: 3,
                      selectedIconName: AppAssets.profileIconSelected,
                      unSelectedIconName: AppAssets.profileIconUnSelected,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required String selectedIconName,
    required String unSelectedIconName,
    String label = '',
    required int index,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: ImageIcon(
        AssetImage(
          selectedIndex == index ? selectedIconName : unSelectedIconName,
        ),
      ),
    );
  }
}
