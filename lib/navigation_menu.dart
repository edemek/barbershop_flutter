import 'package:barbershpo_flutter/features/shop/screens/store/store.dart';
import 'package:barbershpo_flutter/utils/helpers/helper_functions.dart';
import 'package:barbershpo_flutter/utils/validators/validation_.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'a/components/appointment_card.dart';
import 'account/views/account_view_customer.dart';
import 'features/Salon/screen/salon_liste.dart';
import 'features/authentication/screens/login/login.dart';
import 'features/home/custom_drawer.dart';
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
      drawer: const ElegantMenu(),
      appBar: AppBar(
        title: Text("Barber Shop ",style: TextStyle(color: Color(0xFFDFAC1B)),),
        leading: Builder(
          builder: (context) {
            return IconButton(
              color: darkMode ? Colors.white : Colors.black,
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) {
            controller.selectedIndex.value = index;
          },
          backgroundColor: darkMode ? Colors.black : Colors.white,
          indicatorColor: Color(0xFFDFAC1B),
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
            // NavigationDestination(
            //   icon: Icon(
            //     Iconsax.shop,
            //     color: darkMode ? Colors.white : Colors.black,
            //   ),
            //   label: 'Boutique',
            // ),
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

  UserController get userController => Get.find<UserController>(); // Récupération dynamique du UserController grace à get

  List<Widget> get screens {
    return [
      HomeScreen(),
      userController.UToken == ''
          ? LoginScreen() // Redirige si l'utilisateur n'est pas connecté
          : SalonListScreen(),
     userController.UToken == ''? LoginScreen() : AccountViewClient()
    ];
  }
}

