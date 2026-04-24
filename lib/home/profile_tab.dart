import 'package:flutter/material.dart';

import '../core/widgets/custom_elevated_button.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: Column(
          children: [
            Container(
              color: AppColors.darkGreyColor,
              height: height * 0.44,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.04,
                  horizontal: width * 0.04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Image.asset(AppAssets.avatarImage),
                        SizedBox(width: width * 0.05),
                        Column(
                          children: [
                            Text('12', style: AppStyles.robotoBold36White),
                            Text(
                              'Wish List',
                              style: AppStyles.robotoBold24White,
                            ),
                          ],
                        ),
                        SizedBox(width: width * 0.08),
                        Column(
                          children: [
                            Text('10', style: AppStyles.robotoBold36White),
                            Text('History', style: AppStyles.robotoBold24White),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      'User Name',
                      textAlign: TextAlign.left,
                      style: AppStyles.robotoBold20White,
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: CustomElevatedButton(
                            text: 'Edit Profile',
                            backgroundColor: AppColors.yellowColor,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: width * 0.05),
                        Expanded(
                          flex: 3,
                          child: CustomElevatedButton(
                            onPressed: () {},
                            text: 'Exit',
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            icon: true,
                            iconWidget: Image.asset(AppAssets.exitIcon),
                            backgroundColor: AppColors.redColor,
                            textStyle: AppStyles.regular20White,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 21),
                    TabBar(
                      labelStyle: AppStyles.robotoRegular16White,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelPadding: EdgeInsets.symmetric(horizontal: 10),
                      tabAlignment: TabAlignment.fill,
                      dividerColor: AppColors.transparentColor,
                      indicatorColor: AppColors.yellowColor,
                      tabs: [
                        Tab(
                          text: "Watch List",
                          icon: Icon(
                            Icons.list,
                            color: AppColors.yellowColor,
                            size: 40,
                          ),
                        ),
                        Tab(
                          text: "History",
                          icon: Icon(
                            Icons.history,
                            color: AppColors.yellowColor,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(child: Image.asset(AppAssets.emptyListIcon)),
                  Center(child: Image.asset(AppAssets.emptyListIcon)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
