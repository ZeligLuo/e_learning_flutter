import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:e_learning_app/common/utils/image_resources.dart';
import 'package:e_learning_app/common/widgets/image_widgets.dart';
import 'package:e_learning_app/features/home/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var bottomTabs = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
      icon: _bottomContainer(),
      activeIcon: _bottomContainer(color: AppColors.primaryElement),
      backgroundColor: AppColors.primaryBackground,
      label: "Home"),
  BottomNavigationBarItem(
      icon: _bottomContainer(imagePath: ImageResources.searchIcon2),
      activeIcon: _bottomContainer(imagePath: ImageResources.searchIcon2, color: AppColors.primaryElement),
      label: "Search"),
  BottomNavigationBarItem(
      icon: _bottomContainer(imagePath: ImageResources.playIcon),
      activeIcon: _bottomContainer(imagePath: ImageResources.playIcon, color: AppColors.primaryElement),
      label: "Play"),
  BottomNavigationBarItem(
      icon: _bottomContainer(imagePath: ImageResources.messageIcon),
      activeIcon: _bottomContainer(imagePath: ImageResources.messageIcon, color: AppColors.primaryElement),
      label: "Message"),
  BottomNavigationBarItem(
      icon: _bottomContainer(imagePath: ImageResources.profileIcon),
      activeIcon: _bottomContainer(imagePath: ImageResources.profileIcon, color: AppColors.primaryElement),
      label: "Profile"),

];

Widget _bottomContainer(
    {double width = 15,
    double height = 15,
    String imagePath = ImageResources.homeIcon,
    Color color = AppColors.primaryFourthElementText}) {
  return SizedBox(
    width: width.w,
    height: height.h,
    child: appImageWithColor(
        imagePath: imagePath,
        color: color),
  );
}

Widget appScreens({int index=0}) {
  List<Widget> screens = [
    const Home(),
    const Center(child: AppImage(imagePath: ImageResources.searchIcon2),),
    const Center(child: AppImage(imagePath: ImageResources.playIcon),),
    const Center(child: AppImage(imagePath: ImageResources.messageIcon),),
    const Center(child: AppImage(imagePath: ImageResources.profileIcon),)
  ];

  return screens[index];
}
