/*
 * File name: global_service.dart
 * Last modified: 2024.02.05 at 14:50:11
 * Author: harrykouevi - https://github.com/harrykouevi
 * Copyright (c) 2025
 */

import 'package:get/get.dart';

import '../../common/helper.dart';
import '../../models/global_model.dart';

class GlobalService extends GetxService {
  final global = Global().obs;

  Future<GlobalService> init() async {
    // var response = await Helper.getJsonFile('config/global.json')
    // Dummy JSON data
    final response = {
      "laravel_base_url": "https://barber.businesshelpconsulting.com";
      "api_path": "api/",
      "received": 1,
      "accepted": 10,
      "on_the_way": 20,
      "ready": 30,
      "in_progress": 40,
      "done": 50,
      "failed": 60
    };

    global.value = Global.fromJson(response);
    return this;
  }

  String get baseUrl => Helper.toUrl(global.value.laravelBaseUrl ?? '');
}
