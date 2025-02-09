import 'package:barbershpo_flutter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/theme1_app_pages.dart';
import 'features/settings/views/settings_view.dart';
import 'utils/theme/theme_.dart';
 import 'features/authentication/screens/onboarding/onboarding.dart';
 import 'package:barbershpo_flutter/navigation_menu.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TApptheme.lightTheme,
      //darkTheme: TApptheme.darkTheme,
      home: const NavigationMenu()
    );
  }
}
