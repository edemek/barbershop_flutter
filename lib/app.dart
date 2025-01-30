import 'package:barbershpo_flutter/data/services/api_service.dart';
import 'package:barbershpo_flutter/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/auth_controller.dart';
import 'features/authentication/screens/onboarding/onboarding.dart';

class App extends StatelessWidget {
  App({super.key});

  final apiService = Get.put(ApiService());
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BarberShop App',
      themeMode: ThemeMode.system, // Le thème change selon le mode du système
      theme: TAppTheme.lightTheme,  // Thème clair
      darkTheme: TAppTheme.darkTheme, // Thème sombre
      //getPages:[GetPage(name: '/login',page:() => const LoginScreen())],
      //home:  LoginScreen(),
      home: const OnBoardingScreen(),
    );
  }
}
