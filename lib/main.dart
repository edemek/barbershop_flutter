// import 'package:flutter/material.dart';
import 'package:barbershpo_flutter/utils/validators/validation_.dart';
import 'app.dart';
import 'features/Reservation_client/controllers/reservation_controller.dart';
import 'features/services/auth_service.dart';
import 'features/services/settings_service.dart';
import 'features/services/global_service.dart';
import 'features/providers/laravel_provider.dart';
import 'features/settings/controllers/settings_controller.dart';
import 'features/settings/controllers/address_controller.dart';
import 'package:get_storage/get_storage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> initServices() async {
  Get.log('starting services ...');
  await GetStorage.init();
  await Get.putAsync(() => GlobalService().init());
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => LaravelApiClient().init());
  // await Get.putAsync(() => FirebaseProvider().init());
  await Get.putAsync(() => SettingsService().init());
  // await Get.putAsync(() => TranslationService().init());
  Get.log('All services started...');
}

/// ----------  Entry point of Flutter App  ----------
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await initServices();
  Get.put(() => GlobalService());
  Get.put<SettingsController>(SettingsController());
  Get.put(UserController());
  Get.put(AddressController());
  Get.put(ReservationController());

  runApp(App());
}
