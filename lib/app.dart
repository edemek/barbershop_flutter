import 'package:barbershpo_flutter/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/authentication/screens/login/login.dart';
import 'features/authentication/screens/onboarding/onboarding.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BarberShop App',
      themeMode: ThemeMode.system,
      theme: TApptheme.ligthTheme,
      darkTheme: TApptheme.darkTheme,
      getPages:[GetPage(name: '/login',page:() => const LoginScreen())],
      home: const LoginScreen(),
      //home: const OnBoardingScreen(),
    );
  }
}