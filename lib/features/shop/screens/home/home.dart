import 'package:barbershpo_flutter/common/widgets/layouts/grid_layout.dart';
import 'package:barbershpo_flutter/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:barbershpo_flutter/features/shop/screens/home/widgets/home_categories.dart';
import 'package:barbershpo_flutter/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:barbershpo_flutter/utils/constants/image_strings.dart';
import 'package:barbershpo_flutter/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_hearder_container.dart';
import '../../../../navigation_menu.dart';
import '../../../Salon/screen/salon_liste.dart';
import '../../../home/custom_drawer.dart';
import '../categorie/categories_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Ta liste de salons
  final List<Map<String, dynamic>> salonsList = const [
    {
      "name": "Salon Prestige",
      "address": "123 Avenue des Coiffeurs, Lomé",
      "openingHours": "08:00 - 20:00",
      "imageUrls": [
        "assets/images/photo_salon/s (7).jpg",
        "assets/images/photo_salon/s (6).jpg"
      ],
      "phone": "+228 90 00 00 01",
      "email": "contact@salonprestige.com",
      "latitude": 6.1319,
      "longitude": 1.2228,
    },
    {
      "name": "Barber King",
      "address": "456 Rue Royale, Lomé",
      "openingHours": "09:00 - 21:00",
      "imageUrls": [
        "assets/images/photo_salon/s (1).jpg",
        "assets/images/photo_salon/s (4).jpg"
      ],
      "phone": "+228 90 00 00 02",
      "email": "info@barberking.com",
      "latitude": 6.1724,
      "longitude": 1.2085,
    },
    {
      "name": "Miabe Barber",
      "address": "456 Rue Royale, Lomé",
      "openingHours": "09:00 - 21:00",
      "imageUrls": [
        "assets/images/photo_salon/s (1).jpg",
        "assets/images/photo_salon/s (4).jpg"
      ],
      "phone": "+228 90 00 00 02",
      "email": "info@barberking.com",
      "latitude": 6.1724,
      "longitude": 1.2085,
    }
  ];

  final List<Map<String, dynamic>> categories = [
    {
      "icon": Iconsax.scissor,
      "text": "Coupes",
      "color": Colors.red.shade300,
      "bgColor": Colors.red.shade50
    },
    {
      "icon": Icons.woman_rounded,
      "text": "Tresse",
      "color": Colors.blue.shade300,
      "bgColor": Colors.blue.shade50
    },
    {
      "icon": Icons.spa,
      "text": "Massage",
      "color": Colors.purple.shade500,
      "bgColor": Colors.purple.shade50
    },
    {
      "icon": Icons.brush,
      "text": "Makeup",
      "color": Colors.orange.shade500,
      "bgColor": Colors.orange.shade50
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:
          const ElegantMenu(), // Intégration du menu élégant // Intégration du CustomDrawer
      backgroundColor: Colors.green.withOpacity(0.02),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// En-tête et promo
            TPromoSlider(
              banners: [
                TImages.promoBanner1,
                TImages.promoBanner2,
                TImages.promoBanner3,
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Bar de recherche
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.search_normal),
                      labelText: 'Rechercher un service',
                      suffixIconColor: Color(0xFFDFAC1B),
                      suffixIcon: PopupMenuButton<String>(
                        icon: const Icon(Icons.filter_list), // Icône de filtre
                        onSelected: (String value) {
                          // Action de filtre
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                              value: "Tous", child: Text("Tous les services")),
                          const PopupMenuItem(
                              value: "Coupes", child: Text("Coupes")),
                          const PopupMenuItem(
                              value: "Tresses", child: Text("Tresses")),
                          const PopupMenuItem(
                              value: "Massage", child: Text("Massage")),
                          const PopupMenuItem(
                              value: "Makeup", child: Text("Makeup")),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spacetBtwItems),

                  /// Titre et bouton "Voir tout" pour les catégories
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Vos Categories",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFDFAC1B),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CategoriesScreen()),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Tout afficher",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Lister les catégories
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories
                          .map((category) => categoryCard(
                                icon: category["icon"],
                                text: category["text"],
                                color: category["color"],
                                bgColor: category["bgColor"],
                              ),
                      )
                          .toList(),
                    ),
                  )
                ],
              ),
            ),

            /// -- Section recommandée : Intégration de la liste de salons dans un carousel
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recommandé pour vous",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFDFAC1B),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Action pour voir tout
                          Navigator.of(context).pop();
                          final navigationController = Get.find<NavigationController>();
                          navigationController.selectedIndex.value = 1;
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Tout afficher",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Utilisation du carousel pour afficher les salons de la liste
                  TCarouselLayout(
                    itemCount: salonsList.length,
                    itemBuilder: (_, index) {
                      return SalonCard(salon: salonsList[index]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget pour afficher une carte salon
class SalonCard extends StatelessWidget {
  final Map<String, dynamic> salon;

  const SalonCard({Key? key, required this.salon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Affiche la première image du salon
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              salon["imageUrls"][0],
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              salon["name"],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              salon["address"],
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 8)
        ],
      ),
    );
  }
}

/// Widget pour une carte de catégorie
class categoryCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color bgColor;

  const categoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.color,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0), // Marges autour de chaque carte
      width: 120, // Largeur fixe pour chaque carte
      child: AspectRatio(
        aspectRatio: 1.0, // Assurer que la carte est carrée
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centrer le contenu
            children: [
              Icon(
                icon,
                color: color,
                size: 30,
              ),
              SizedBox(height: 5),
              Text(
                text,
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
