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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
    }
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
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  THomeAppBar(),
                  const SizedBox(height: TSizes.spacetBtwSections),
                  const TPromoSlider(
                    banners: [
                      TImages.promoBanner1,
                      TImages.promoBanner2,
                      TImages.promoBanner3,
                    ],
                  ),

                ],
              ),
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
                  const SizedBox(height: TSizes.spacetBtwSections),

                  /// Titre et bouton "Voir tout" pour les catégories
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Vos Categories",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Action pour voir toutes les catégories
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Voir tout",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  // Liste des catégories
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      categoryCard(
                        icon: Iconsax.scissor,
                        text: "Coupes",
                        color: Colors.red.shade300,
                        bgColor: Colors.red.shade50,
                      ),
                      categoryCard(
                        icon: Icons.woman_rounded,
                        text: "Tresse",
                        color: Colors.blue.shade300,
                        bgColor: Colors.blue.shade50,
                      ),
                      categoryCard(
                        icon: Icons.spa,
                        text: "Massage",
                        color: Colors.purple.shade500,
                        bgColor: Colors.purple.shade50,
                      ),
                      categoryCard(
                        icon: Icons.brush,
                        text: "Makeup",
                        color: Colors.orange.shade500,
                        bgColor: Colors.orange.shade50,
                      ),
                    ],
                  ),
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
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Action pour voir tout
                          Get.to(() => SalonListScreen());
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Voir tout",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spacetBtwItems / 4),

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
Widget categoryCard({
  required IconData icon,
  required String text,
  required Color color,
  required Color bgColor,
}) {
  return Container(
    width: 90,
    height: 100,
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 40),
        const SizedBox(height: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    ),
  );
}
