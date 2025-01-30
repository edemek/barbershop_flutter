import 'package:barbershpo_flutter/utils/validators/validation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app.dart';

/// ----------  Entry point of Flutter App  ----------
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  Get.put(UserController()); //

  runApp(App());
}
