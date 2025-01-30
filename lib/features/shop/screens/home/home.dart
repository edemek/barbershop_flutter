import 'package:barbershpo_flutter/common/widgets/layouts/grid_layout.dart';
import 'package:barbershpo_flutter/common/widgets/products/product_card_vertical.dart';
import 'package:barbershpo_flutter/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:barbershpo_flutter/features/shop/screens/home/widgets/home_categories.dart';
import 'package:barbershpo_flutter/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:barbershpo_flutter/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_hearder_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                /// -- Searchbar
                TSearchContainer(
                  text: '  Faire une recherche',
                ),

                const SizedBox(
                  height: TSizes.spacetBtwSections,
                ),

                /// -- Catégories
                Padding(
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
                ),
              ]),
            ),

            /// -- Body
            Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    /// -- Promo Slider
                    const TPromoSlider(
                      banners: [
                        TImages.promoBanner1,
                        TImages.promoBanner2,
                        TImages.promoBanner3,
                      ],
                    ),
                    const SizedBox(height: TSizes.spacetBtwSections),

                    /// -- Heading
                    /*TSectionHeading(
                      title: 'Services Populaire',
                      onPressed: () {},
                    ),

                    const SizedBox(height: TSizes.spacetBtwItems),

                     */

                    /// -- Popular Products
                    TGridLayout(
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
                )),
          ],
        ),
      ),
    );
  }
}
