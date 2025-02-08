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
    var response = await Helper.getJsonFile('config/global.json');
    global.value = Global.fromJson(response);
    return this;
  }

  String get baseUrl => Helper.toUrl(global.value.laravelBaseUrl ?? '');
}
