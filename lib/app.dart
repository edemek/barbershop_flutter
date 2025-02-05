import 'package:barbershpo_flutter/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/theme1_app_pages.dart';

// import 'features/authentication/screens/onboarding/onboarding.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TApptheme.ligthTheme,
      darkTheme: TApptheme.darkTheme,
      // home: const OnBoardingScreen()
      initialRoute: '/', // Define the initial route
      routes: Theme1AppPages.routes,
    );
  }
}
