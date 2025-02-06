import 'package:barbershpo_flutter/common/widgets/layouts/grid_layout.dart';
import 'package:barbershpo_flutter/common/widgets/products/product_card_vertical.dart';
import 'package:barbershpo_flutter/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:barbershpo_flutter/features/shop/screens/home/widgets/home_categories.dart';
import 'package:barbershpo_flutter/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:barbershpo_flutter/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_hearder_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.withOpacity(0.02),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Tutorial [Section # 5, video # 2]
            TPrimaryHeaderContainer(
              child: Column(children: [
                /// -- Appbar
                THomeAppBar(),
                const SizedBox(
                  height: TSizes.spacetBtwSections,
                ),

                /// -- Promo Slider
                const TPromoSlider(
                  banners: [
                    TImages.promoBanner1,
                    TImages.promoBanner2,
                    TImages.promoBanner3,
                  ],
                ),
              ]
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- Bar de recherche
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.search_normal),
                      labelText: 'Rechercher un service',
                      suffixIcon: PopupMenuButton<String>(
                        icon: Icon(Icons.filter_list), // Icône de filtre
                        onSelected: (String value) {
                          //setState(() {
                          // _selectedFilter = value; // Met à jour le filtre sélectionné
                          //});
                        },
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                              value: "Tous", child: Text("Tous les services")),
                          PopupMenuItem(value: "Coupes", child: Text("Coupes")),
                          PopupMenuItem(
                              value: "Tresses", child: Text("Tresses")),
                          PopupMenuItem(
                              value: "Massage", child: Text("Massage")),
                          PopupMenuItem(value: "Makeup", child: Text("Makeup")),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: TSizes.spacetBtwSections,
                  ),

                  /// -- Titre et bouton "Tous voir"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
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
                        child: Text(
                          "Voir tout",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
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

            /// -- Body
            Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recommandé pour vous",
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
                            backgroundColor: Colors.blue.shade50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Voir tout",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: TSizes.spacetBtwItems / 4),

                    /// -- Heading
                    /*TSectionHeading(
                      title: 'Services Populaire',
                      onPressed: () {},
                    ),

                    const SizedBox(height: TSizes.spacetBtwItems),

                     */

                    /// -- Popular Products

                    TCarouselLayout(
                      itemCount: 8,
                      itemBuilder: (_, index) => const TProductCardVertical(),
                    ),
                    /*
                    GridView.builder(
                      itemCount: 8,
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                          mainAxisSpacing: TSizes.gridViewSpacing,
                          crossAxisSpacing:  TSizes.gridViewSpacing,
                          mainAxisExtent: 288,
                        ),
                      itemBuilder: (_, index) => const TProductCardVertical(),)
                      */
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}

// Widget pour une carte de catégorie
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
      boxShadow: [
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
        SizedBox(height: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    ),
  );
}

/// -- Catégories peti rond avec icon
/*Padding(
                  padding: const EdgeInsets.only(
                    left: TSizes.defaultSpace,
                  ),
                  child: Column(
                    children: [
                      /// -- Heading
                      const TSectionHeading(
                        title: 'Catégories Populaire',
                        showActionButton: false,
                        textColor: Colors.white,
                      ),

                      const SizedBox(height: TSizes.spacetBtwItems),

                      /// -- Categories
                      THomeCategories(),
                    ],
                  ),
                ),*/
