import 'package:barbershpo_flutter/features/shop/screens/store/store.dart';
import 'package:barbershpo_flutter/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'a/components/appointment_card.dart';
import 'account/views/account_view_customer.dart';
import 'features/Salon/screen/salon_liste.dart';
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
        title: Text("Barber Shop ",style: TextStyle(color: Colors.blue),),
        leading: Builder(
          builder: (context) {
            return IconButton(
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

  final List<Widget> screens = [
    const HomeScreen(),

  //const StoreScreen(),
   //const AppointmentCard(),
    SalonListScreen(),
    const AccountViewClient()

  ];
}




class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade700, Colors.green.shade300],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Menu icon
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.menu, color: Colors.black),
                  onPressed: () {},
                ),
              ),
              // Title
              Text(
                "Beauty Salons",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              // Notification icon with badge
              Align(
                alignment: Alignment.centerRight,
                child: Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.notifications, color: Colors.black),
                      onPressed: () {},
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.green.shade900,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "0",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
