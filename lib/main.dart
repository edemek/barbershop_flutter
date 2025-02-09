import 'package:barbershpo_flutter/utils/validators/validation_.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'features/Reservation_client/controllers/reservation_controller.dart';
import 'features/services/auth_service.dart';
import 'features/services/settings_service.dart';
import 'features/services/global_service.dart';
import 'features/providers/laravel_provider.dart';
import 'features/settings/controllers/settings_controller.dart';

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


Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Vérifier si le service de localisation est activé
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Les services de localisation sont désactivés.');
  }

  // Vérifier la permission
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('La permission de localisation est refusée.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception(
        'Les permissions de localisation sont définitivement refusées.');
  }

  // Récupérer la position actuelle
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

Future<void> getAddressFromLatLng(Position position) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);

    Placemark place = placemarks[0];
    print('${place.street}, ${place.locality}, ${place.country}');
  } catch (e) {
    print(e);
  }
}

/// ----------  Entry point of Flutter App  ----------
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  Get.put<SettingsController>(SettingsController());

  /// -- Avoir la position
  //Position position = await _determinePosition();
  //print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');

  Get.put(UserController());
  Get.put(ReservationController());
  runApp(App());
}


