import 'package:get/get.dart';
import '../middlewares/auth_middleware.dart';
import '../features/root/views/root_view.dart';
import '../features/settings/views/settings_view.dart';
import '../features/settings/views/addresses_view.dart';
import '../features/settings/views/theme_mode_view.dart';
import '../features/settings/bindings/settings_binding.dart';
import 'app_routes.dart';

class Theme1AppPages {
  static const INITIAL = Routes.ROOT;
  // {
  //   '/': (context) => const FirstPage(), // Route for FirstPage
  //   '/second': (context) => const SecondPage(), // Route for SecondPage
  //   '/third': (context) => const ThirdPage(), // Route for ThirdPage
  // };

  static final routes = [
    GetPage(
        name: Routes.SETTINGS,
        page: () => SettingsView(),
        binding: SettingsBinding()),
    GetPage(
        name: Routes.SETTINGS_ADDRESSES,
        page: () => AddressesView(),
        binding: SettingsBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.SETTINGS_THEME_MODE,
        page: () => ThemeModeView(),
        binding: SettingsBinding()),
    // GetPage(
    //     name: Routes.SETTINGS_LANGUAGE,
    //     page: () => LanguageView(),
    //     binding: SettingsBinding()),
    // GetPage(
    //     name: Routes.SETTINGS_ADDRESS_PICKER, page: () => AddressPickerView()),
  ];
}
