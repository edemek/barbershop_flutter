import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';

class SearchController extends GetxController {
  final heroTag = "".obs;
  final categories = <Map<String, String>>[].obs; // Simule les catégories
  final selectedCategories = <String>[].obs;
  late TextEditingController textEditingController;

  final eServices = <Map<String, String>>[].obs; // Simule les services

  SearchController() {
    textEditingController = TextEditingController();
  }

  @override
  void onInit() async {
    await refreshSearch();
    super.onInit();
  }

  @override
  void onReady() {
    heroTag.value = Get.arguments as String;
    super.onReady();
  }

  Future refreshSearch({bool? showMessage}) async {
    await getCategories();
    await searchEServices();
    if (showMessage == true) {
      Get.showSnackbar(Ui.SuccessSnackBar(message: "List of services refreshed successfully".tr));
    }
  }

  Future searchEServices({String? keywords}) async {
    try {
      List<Map<String, String>> allServices = [
        {"id": "1", "name": "Plumbing"},
        {"id": "2", "name": "Electrician"},
        {"id": "3", "name": "House Cleaning"},
      ];

      if (selectedCategories.isEmpty) {
        eServices.assignAll(allServices);
      } else {
        eServices.assignAll(allServices.where((service) => selectedCategories.contains(service["id"])).toList());
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getCategories() async {
    try {
      categories.assignAll([
        {"id": "1", "name": "Home Services"},
        {"id": "2", "name": "Tech Support"},
        {"id": "3", "name": "Automobile"},
      ]);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  bool isSelectedCategory(Map<String, String> category) {
    return selectedCategories.contains(category["id"]);
  }

  void toggleCategory(bool value, Map<String, String> category) {
    if (value) {
      selectedCategories.add(category["id"]!);
    } else {
      selectedCategories.removeWhere((element) => element == category["id"]);
    }
  }
}
