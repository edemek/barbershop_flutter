import 'package:barbershpo_flutter/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'features/Reservation_client/controllers/reservation_controller.dart';

/// ----------  Entry point of Flutter App  ----------
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  Get.put(UserController());
  Get.put(ReservationController());//
  runApp(App());
  Get.put(UserController()); //

  runApp(App());
}
