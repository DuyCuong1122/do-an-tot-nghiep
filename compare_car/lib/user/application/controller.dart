import 'package:flutter/material.dart';

import '../../common/values/colors.dart';
import 'index.dart';

import 'package:get/get.dart';

class ApplicationController extends GetxController {
  final state = ApplicationState();
  ApplicationController();

  late final List<String> tabTitles;
  late final PageController pageController;
  late final List<BottomNavigationBarItem> bottomTabs;

  void handPageChanged(int index) {
    state.page = index;
  }

  void handleNavBarTap(int index) {
    pageController.jumpToPage(index);
  }

  @override
  void onInit() {
    super.onInit();
    tabTitles = ['Homepage', 'Community', 'Chatbot'];
    bottomTabs = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.black),
          activeIcon: Icon(
            Icons.home,
            color: AppColors.secondaryElementText,
          ),
          label: 'Homepage',
          backgroundColor: AppColors.primaryBackground),
      const BottomNavigationBarItem(
          icon: Icon(Icons.people, color: AppColors.thirdElementText),
          activeIcon: Icon(
            Icons.people,
            color: AppColors.secondaryElementText,
          ),
          label: 'Community',
          backgroundColor: AppColors.primaryBackground),
      const BottomNavigationBarItem(
          icon: Icon(Icons.chat, color: AppColors.thirdElementText),
          activeIcon: Icon(
            Icons.chat,
            color: AppColors.secondaryElementText,
          ),
          label: 'Chatbot',
          backgroundColor: AppColors.primaryBackground),
    ];
    pageController = PageController(initialPage: state.page);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
