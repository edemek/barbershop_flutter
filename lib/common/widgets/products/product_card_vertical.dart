import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/sizes.dart';
import '../icons/t_circular_icon.dart';
import 'package:barbershpo_flutter/common/styles/shadows.dart';
import 'package:barbershpo_flutter/common/widgets/containers/TRounded_container.dart';
import 'package:barbershpo_flutter/common/widgets/images/t_rounded_image.dart';
import 'package:barbershpo_flutter/common/widgets/texts/product_price_text.dart';
import 'package:barbershpo_flutter/common/widgets/texts/product_title_text.dart';
import 'package:barbershpo_flutter/utils/constants/colors.dart';
import 'package:barbershpo_flutter/utils/constants/image_strings.dart';
import 'package:barbershpo_flutter/utils/helpers/helper_functions.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkGrey : TColors.white,
        ),
        child: SizedBox(
          height: 220,
          child: Column(
            children: [
              /// -- Thumbnail, Wishlist Button, Discount Tag
              TRoundedContainer(
                height: 120,
                width: 190, // Adjusted width to create more space
                padding: const EdgeInsets.all(TSizes.sm),
                backgroundColor: dark ? TColors.dark : TColors.light,
                child: Stack(
                  children: [
                    /// -- Thumbnail Image takes the whole background
                    Positioned.fill(
                      child: TRoundedImage(
                        imageUrl: TImages.promoBanner1,
                        applyImageRadius: true,
                        //boxFit: BoxFit.cover,  // Ensures the image covers the full space
                      ),
                    ),

                    /// -- Sale Tag
                    Positioned(
                      top: 12,
                      child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text(
                          '25%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: TColors.black),
                        ),
                      ),
                    ),

                    /// -- Favorite Icon Button
                    const Positioned(
                      top: 0,
                      right: 0,
                      child: TCircularIcon(
                        icon: Iconsax.heart5,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: TSizes.spacetBtwItems / 2),

              /// -- Details
              Padding(
                padding: const EdgeInsets.only(left: TSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TProductTitleText(
                      title: 'Nom du salon',
                      smallSize: true,
                    ),

                    /// -- Distance to you Row
                    Row(
                      children: [
                        Text(
                          '0.5 km',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(width: TSizes.xs),
                        const Icon(
                          Iconsax.verify5,
                          color: TColors.primary,
                          size: TSizes.iconXs,
                        ),
                      ],
                    ),

                    /// -- Price Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TProductPriceText(price: '1500'),

                        /// -- Add to Card Button
                        Container(
                          decoration: const BoxDecoration(
                            color: TColors.dark,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(TSizes.cardRadiusMd),
                              bottomRight: Radius.circular(TSizes.productImageRadius),
                            ),
                          ),
                          child: SizedBox(
                            width: TSizes.iconLg * 1.2,
                            height: TSizes.iconLg * 1.2,
                            child: Center(
                              child: Icon(
                                Iconsax.add,
                                color: TColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
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
