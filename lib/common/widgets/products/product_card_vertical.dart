import 'package:barbershpo_flutter/common/styles/shadows.dart';
import 'package:barbershpo_flutter/common/widgets/containers/TRounded_container.dart';
import 'package:barbershpo_flutter/common/widgets/images/t_rounded_image.dart';
import 'package:barbershpo_flutter/common/widgets/texts/product_price_text.dart';
import 'package:barbershpo_flutter/common/widgets/texts/product_title_text.dart';
import 'package:barbershpo_flutter/utils/constants/colors.dart';
import 'package:barbershpo_flutter/utils/constants/image_strings.dart';
import 'package:barbershpo_flutter/utils/constants/sizes.dart';
import 'package:barbershpo_flutter/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


import '../icons/t_circular_icon.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    /// -- Container with side paddings, color, edges, radius and shadows.
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
        child: Column(
          children: [
            /// -- Thunbnail, WIshlist Button, Discount Tag
            TRoundesContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  /// -- Thunbnail Image
                  TRoundedImage(
                    imageUrl: TImages.onBoardingImage2,
                    applyImageRadius: true,
                  ),

                  /// -- Sale Tag
                  Positioned(
                    top: 12,
                    child: TRoundesContainer(
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
                    title: 'Le titre ici',
                    smallSize: true,
                  ),
                  const SizedBox(height: TSizes.spacetBtwItems / 2,),
                  Row(
                    children: [
                      Text('data', overflow: TextOverflow.ellipsis, maxLines: 1, style: Theme.of(context).textTheme.labelMedium,),
                      const SizedBox(width: TSizes.xs),
                      const Icon(Iconsax.verify5, color: TColors.primary, size: TSizes.iconXs,)
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// -- Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// -- Price
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
    );
  }
}

