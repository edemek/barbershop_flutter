import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'navigation_menu.dart';
import 'utils/theme/theme_.dart';
import 'features/settings/views/settings_view.dart';

import 'features/authentication/screens/onboarding/onboarding.dart';
import 'routes/theme1_app_pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        themeMode: ThemeMode.system,
        theme: TApptheme.lightTheme,
        darkTheme: TApptheme.darkTheme,
        // home: SettingsView());
        home: const OnBoardingScreen());
  }
}
