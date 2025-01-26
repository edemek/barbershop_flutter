import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../screens/login/login.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  /// Variable
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  /// Update Current Index when Page Scroll
  void updatePageIndicator(int index) {
    currentPageIndex.value = index;  // Mise à jour de la valeur correcte
  }

  /// Jump to the specific dot selected page.
  void dotNavigationClick(int index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);  // Utilisation de jumpToPage pour le défilement
  }

  /// Update Current Index & jump to next page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      Get.offAll(() => LoginScreen());
      //getPages:[GetPage(name: '/login',page:() => const LoginScreen())];
    } else {
      int page = currentPageIndex.value + 1;  // Passer à la page suivante
      pageController.jumpToPage(page);
      currentPageIndex.value = page;  // Mise à jour de l'index après la navigation
    }
  }

  /// Update Current Index & jump to the Login Page
  void skipPage() {
    currentPageIndex.value = 2; // Option de saut pour aller directement à la dernière page
    pageController.jumpToPage(2);
    Get.offAll(() => LoginScreen());
  }
}
