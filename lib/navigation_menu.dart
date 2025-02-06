import 'package:barbershpo_flutter/features/shop/screens/store/store.dart';
import 'package:barbershpo_flutter/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'a/components/appointment_card.dart';
import 'account/views/account_view_customer.dart';
import 'features/Salon/screen/salon_liste.dart';
import 'features/shop/screens/home/home.dart';
import 'features/shop/screens/reservations.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    // Recalculer le mode sombre à chaque reconstruction de l'interface.
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) {
            controller.selectedIndex.value = index;
          },
          backgroundColor: darkMode ? Colors.black : Colors.white,
          indicatorColor: darkMode
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.1),
          surfaceTintColor:
              Colors.transparent, // Supprimer tout effet de teinte par défaut
          destinations: [
            NavigationDestination(
              icon: Icon(
                Iconsax.home,
                color: darkMode ? Colors.white : Colors.black,
              ),
              label: 'Accueil',
            ),
            NavigationDestination(
              icon: Icon(
                Iconsax.shop,
                color: darkMode ? Colors.white : Colors.black,
              ),
              label: 'Boutique',
            ),
            NavigationDestination(
              icon: Icon(
                Iconsax.calendar,
                color: darkMode ? Colors.white : Colors.black,
              ),
              label: 'Réservation',
            ),
            NavigationDestination(
              icon: Icon(
                Iconsax.user,
                color: darkMode ? Colors.white : Colors.black,
              ),
              label: 'Profil',
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final List<Widget> screens = [
    const HomeScreen(),

  const StoreScreen(),
   //const AppointmentCard(),
    SalonListScreen(),
    const AccountViewClient()

  ];
}
