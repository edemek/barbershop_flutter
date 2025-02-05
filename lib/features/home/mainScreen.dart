import 'package:barbershpo_flutter/features/home/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../account/views/account_view.dart';
import '../../utils/constants/colors.dart';

class MainScreeen extends StatefulWidget {
  const MainScreeen({super.key});

  @override
  State<MainScreeen> createState() => _MainScreeen();
}

class _MainScreeen extends State<MainScreeen> {
  int selectedIndex = 0;

  final List pages = [
    MyHomeScreen(),
    const Scaffold(),
    const Scaffold(),
    AccountView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          unselectedItemColor: TColors.buttonSecondary,
          selectedItemColor: TColors.buttonPrimary,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Iconsax.home5), label: 'Acceuil'),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.message), label: 'Messages'),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.calendar), label: 'Planing'),
            BottomNavigationBarItem(
                icon: Icon(Iconsax.setting), label: 'Profil'),
          ]),
      body: pages[selectedIndex],
    );
  }
}
