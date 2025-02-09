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
import '../../../../../controllers/auth_controller.dart';
import 'features/authentication/controllers/onboard_controller.dart';
import 'package:flutter/material.dart';
import 'features/root/controllers/root_controller.dart';
import 'features/home/controllers/home_controller.dart';
import '../../../../common/ui.dart';


import 'package:get/get.dart';

Future<void> initServices() async {
  Get.log('starting services ...');
  try {
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
  } catch (e) {
    print(e); // Log the error to the console for debugging
    Get.showSnackbar(Ui.ErrorSnackBar(message: 'An error occurred during initialization: ${e.toString()}'.tr)); // Show error to the user
  }
}

/// ----------  Entry point of Flutter App  ----------
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await initServices();
  try {
    Get.put(() => GlobalService());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => RootController());
    Get.lazyPut(() => HomeController());
    Get.put(() => OnBoardingController());
    Get.put(() => OnBoardingController());
    Get.put<SettingsController>(SettingsController());
    Get.put(UserController());
    Get.put(AddressController());
    Get.put(ReservationController());
  
    runApp(App());
  } catch (e) {
    print(e); // Log the error
    Get.showSnackbar(Ui.ErrorSnackBar(message: 'Error during controller/UI setup: ${e.toString()}'.tr));
  }
}
