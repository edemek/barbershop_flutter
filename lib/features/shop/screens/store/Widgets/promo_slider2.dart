import 'package:barbershpo_flutter/features/shop/controllers/home_controller.dart';
import 'package:barbershpo_flutter/utils/constants/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/sizes.dart';

class TPromoSlider2 extends StatelessWidget {
  const TPromoSlider2({
    super.key,
    required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Column(
      children: [
        CarouselSlider(
            items: banners.map((url) => TRoundedImage(imageUrl: url)).toList(),
            options: CarouselOptions(
              height: 200,
              aspectRatio: 20/9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 7),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              onPageChanged: (index, _) => controller.updatePageIndicator(index),
              scrollDirection: Axis.horizontal,
            )
        ),
        const SizedBox(height: TSizes.spacetBtwItems),
        Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < banners.length; i++)
                  TCircularContainer(
                    width: 20,
                    height: 4,
                    margin: EdgeInsets.only(right: 10),
                    backgroundColor: controller.carouselCurrentIndex.value == i
                        ? TColors.primary
                        : TColors.grey,
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
