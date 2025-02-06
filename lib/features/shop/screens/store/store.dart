import 'package:barbershpo_flutter/common/widgets/appbar/appbar.dart';
import 'package:barbershpo_flutter/common/widgets/appbar/tabbar.dart';
import 'package:barbershpo_flutter/common/widgets/containers/TRounded_container.dart';
import 'package:barbershpo_flutter/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:barbershpo_flutter/common/widgets/layouts/grid_layout.dart';
import 'package:barbershpo_flutter/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:barbershpo_flutter/common/widgets/texts/section_heading.dart';
import 'package:barbershpo_flutter/utils/constants/colors.dart';
import 'package:barbershpo_flutter/utils/constants/enums.dart';
import 'package:barbershpo_flutter/utils/constants/sizes.dart';
import 'package:barbershpo_flutter/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/images/t_circular_image.dart';
import '../../../../common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../home/widgets/promo_slider.dart';
import 'Widgets/promo_slider2.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            'Boutique',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCartCounterIcon(onPressed: () {}),
          ],
        ),
        body: NestedScrollView(
          /// -- Header
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: THelperFunctions.isDarkMode(context)
                    ? TColors.black
                    : TColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      /// -- Promo Slider
                      const TPromoSlider2(
                        banners: [
                          TImages.promoBanner1,
                          TImages.promoBanner2,
                          TImages.promoBanner3,
                        ],
                      ), /// -- Bar de recherche
                      SizedBox(
                        height: TSizes.spacetBtwItems,
                      ),

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
                              PopupMenuItem(value: "Tous", child: Text("Tous les services")),
                              PopupMenuItem(value: "Skin", child: Text("Skin")),
                              PopupMenuItem(value: "Massage", child: Text("Massage")),
                              PopupMenuItem(value: "Makeup", child: Text("Makeup")),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: TSizes.spacetBtwSections,
                      ),

                      /// -- Featured Brands
                      TSectionHeading(
                        title: 'Featured Brands',
                        onPressed: () {},
                      ),
                      const SizedBox(height: TSizes.spacetBtwItems / 1.5),

                      /// -- Brand GRID
                      TGridLayout(
                          itemCount: 4,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) {
                            return TBrandCard(showBorder: false,);
                          }),
                    ],
                  ),
                ),

                /// -- Tabs
                bottom: TTabBar(
                  tabs: [
                    Tab(
                      child: Text('Coupes'),
                    ),
                    Tab(
                      child: Text('Tresses'),
                    ),
                    Tab(
                      child: Text('Meche'),
                    ),
                    Tab(
                      child: Text('Tissage'),
                    ),
                    Tab(
                      child: Text('Teinte'),
                    ),
                  ],
                ),
              ),
            ];
          },

          /// -- Boby
          body: TabBarView(children: [
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// -- Brands
                  TRoundedContainer(
                    shadowBorder: true,
                    borderColor: TColors.darkGrey,
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.all(TSizes.md),
                    margin: const EdgeInsets.only(bottom: TSizes.spacetBtwItems),
                    child: Column(
                      children: [
                        /// -- Brand with Products Count
                        const TBrandCard(showBorder: false),
                        /// -- Brand Top 3 Product Image
                        Row(
                          children: [
                            Expanded(
                              child: TRoundedContainer(
                                height: 100,
                                backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkGrey : TColors.light,
                                margin: const EdgeInsets.only(right: TSizes.sm),
                                padding: const EdgeInsets.all(TSizes.md),
                                child: const Image(fit: BoxFit.contain, image: AssetImage(TImages.productImage1),),
                              ),
                            ),
                            Expanded(
                              child: TRoundedContainer(
                                height: 100,
                                backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkGrey : TColors.light,
                                margin: const EdgeInsets.only(right: TSizes.sm),
                                padding: const EdgeInsets.all(TSizes.md),
                                child: const Image(fit: BoxFit.contain, image: AssetImage(TImages.productImage1),),
                              ),
                            ),
                            Expanded(
                              child: TRoundedContainer(
                                height: 100,
                                backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkGrey : TColors.light,
                                margin: const EdgeInsets.only(right: TSizes.sm),
                                padding: const EdgeInsets.all(TSizes.md),
                                child: const Image(fit: BoxFit.contain, image: AssetImage(TImages.productImage1),),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// -- Products
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key, required this.showBorder, this.onTap,
  });
  
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        shadowBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            /// -- Icon
            Flexible(
              child: TCircularImage(
                isNetworkImage: false,
                image: TImages.clothIcon,
                backgroundColor: Colors.transparent,
                overlayColor: THelperFunctions.isDarkMode(context)
                    ? TColors.white
                    : TColors.black,
              ),
            ),
            const SizedBox(height: TSizes.spacetBtwItems / 2),

            /// -- Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBrandTitleWithVerifiedIcon(
                    title: 'Coupe Homme',
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    '256 Salons',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
