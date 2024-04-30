import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {

  final count = 0.obs;
  late final PageController pageController;
  late final TabController tabController;
  int currentPageIndex = 0;

  @override
  void onInit() {
    super.onInit();
        pageController = PageController(initialPage: 0);
    tabController = TabController(length: 4, vsync: this);
  }

 void handlePageViewChanged(int currentPageIndex) {
    tabController.index = currentPageIndex;
      currentPageIndex = currentPageIndex; 
  }
void updateCurrentPageIndex(int index) {
    tabController.index = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
    tabController.dispose();  
  }

}
