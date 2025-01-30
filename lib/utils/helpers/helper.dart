/*
 * File name: helper.dart
 * Last modified: 2022.10.16 at 12:23:14
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'dart:convert' as convert;

import 'package:flutter/services.dart';
import 'package:get/get.dart';


import '../../common/ui.dart';


class Helper {
  DateTime? currentBackPressTime;

  static Future<dynamic> getJsonFile(String path) async {
    return rootBundle.loadString(path).then(convert.jsonDecode);
  }

  static String toUrl(String path) {
    if (!path.endsWith('/')) {
      path += '/';
    }
    return path;
  }

  static String toApiUrl(String path) {
    path = toUrl(path);
    if (!path.endsWith('/')) {
      path += '/';
    }
    return path;
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.showSnackbar(Ui.defaultSnackBar(message: "Tap again to leave!".tr));
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }

}