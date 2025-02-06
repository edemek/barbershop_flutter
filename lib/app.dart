import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/theme1_app_pages.dart';
import 'features/settings/views/settings_view.dart';
import 'utils/theme/theme_.dart';
// import 'features/authentication/screens/onboarding/onboarding.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TApptheme.ligthTheme,
      darkTheme: TApptheme.darkTheme,
      home: SettingsView(), // Utilise la propriété 'home' pour définir l'écran d'accueil
      // initialRoute: '/', // Définir la route initiale si besoin
      // routes: Theme1AppPages.routes,
    );
  }
}
