import 'package:barbershpo_flutter/features/home/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../utils/constants/colors.dart';
import '../../utils/validators/validation_.dart';
import 'custom_drawer.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  String searchText = "";
  String searchFilter = "Tous";

  // Fonction appelée lors de la recherche
  void _handleSearch(String text, String filter) {
    setState(() {
      searchText = text;
      searchFilter = filter;
    });
    // Ici, tu peux ajouter le code pour filtrer les salons/services
  }

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    String name = userController.firstName.value;

    return Scaffold(
      drawer: const ElegantMenu(), // Intégration correcte du drawer dans le Scaffold
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "$name",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: TColors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Image.asset(
                        'assets/icons/hand.png',
                        height: 40,
                        width: 40,
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 27,
                    backgroundImage: Image.asset(
                      'assets/images/on_boarding_images/onboard.jpg',
                    ).image,
                  )
                ],
              ),
            ),
            const SizedBox(height: 20), // Espacement entre le header et la barre de recherche
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SearchBarWidget(
                onSearch: _handleSearch,
                onSortChange: (String _) {},
              ), // Ajout de la barre de recherche
            ),
            const SizedBox(height: 20), // Espacement après la barre de recherche
            // Ici tu peux ajouter la liste des salons filtrés
            Expanded(
              child: Center(
                child: Text('Résultat de recherche'), // Exemple de résultat
              ),
            ),
          ],
        ),
      ),
    );
  }
}
