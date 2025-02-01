import 'package:barbershpo_flutter/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'features/Reservation_client/controllers/reservation_controller.dart';

/// ----------  Entry point of Flutter App  ----------
void main() {
  // Todo: Add Widgets Binding
  // Todo: Init Local Storage
  // Todo: Await Native Splash
  // Todo: Initialize Firebase
  // Todo: Initialize Authentication

  Get.put(UserController());
  Get.put(ReservationController());//
  runApp(const App());
}
