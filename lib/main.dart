import 'package:barbershpo_flutter/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'features/Reservation_client/controllers/reservation_controller.dart';
import 'features/services/auth_service.dart';
import 'features/services/settings_service.dart';
import 'features/services/global_service.dart';
import 'features/providers/laravel_provider.dart';

Future<void> initServices() async {
  Get.log('starting services ...');
  // await GetStorage.init();
  await Get.putAsync(() => GlobalService().init());
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => LaravelApiClient().init());
  // await Get.putAsync(() => LaravelApiClient().init());
  // await Get.putAsync(() => FirebaseProvider().init());
  await Get.putAsync(() => SettingsService().init());
  // await Get.putAsync(() => TranslationService().init());
  Get.log('All services started...');
}

/// ----------  Entry point of Flutter App  ----------
void main() {
  // Todo: Add Widgets Binding
  // Todo: Init Local Storage
  // Todo: Await Native Splash
  // Todo: Initialize Firebase
  // Todo: Initialize Authentication

  Get.put(UserController());
  Get.put(ReservationController()); //
  runApp(const App());
}
