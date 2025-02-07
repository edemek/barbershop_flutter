/*
 * File name: settings_view.dart
 * Last modified: 2023.01.26 at 18:27:06
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2023
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../routes/app_routes.dart';
import '../controllers/settings_controller.dart';
import 'package:barbershpo_flutter/utils/helpers/helper_functions.dart';

class SettingsView extends GetView<SettingsController> {
  final _navigatorKey = Get.nestedKey(1);

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    // final controller = Get.put(NavigationController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings".tr, style: context.textTheme.titleLarge),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      // body: _buildBody(controller), // Pass the controller to _buildBody
      body: Navigator(
        key: _navigatorKey,
        initialRoute: Routes.SETTINGS_ADDRESSES, // Set the initial route
        onGenerateRoute: controller.onGenerateRoute,
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: (index) {
            // controller.selectedIndex.value = index;
            controller.changePage(index);
          },
          backgroundColor: darkMode ? Colors.black : Colors.white,
          indicatorColor: darkMode
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.1),
          surfaceTintColor: Colors.transparent,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Iconsax.home,
                color: darkMode ? Colors.white : Colors.black,
              ),
              label: 'Profile',
            ),
            NavigationDestination(
              icon: Icon(
                Iconsax.shop,
                color: darkMode ? Colors.white : Colors.black,
              ),
              label: 'Adresses',
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildBody(NavigationController controller) {
  //   // Replace this with your actual body content based on the selected index
  //   return Obx(() {
  //     switch (controller.selectedIndex.value) {
  //       case 0:
  //         return Center(child: Text('Home Page'));
  //       case 1:
  //         return Center(child: Text('Shop Page'));
  //       case 2:
  //         return Center(child: Text('Reservation Page'));
  //       case 3:
  //         return Center(child: Text('Profile Page'));
  //       default:
  //         return Center(child: Text('Unknown Page'));
  //     }
  //   });
  // }
}
