import 'package:barbershpo_flutter/features/shop/controllers/home_controller.dart';
import 'package:barbershpo_flutter/utils/constants/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../categorie/pageScreen.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
    required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double sliderHeight = screenHeight * 0.32; // 20% de la hauteur

    return Column(
      children: [
        CarouselSlider(
          items: banners.map((url) =>
              SizedBox(
                width: screenWidth, // 100% de la largeur
                height: sliderHeight, // 20% de la hauteur
                child: TRoundedImage(
                  onPressed: () {Get.to(() => PageScreenNew());},
                  imageUrl: url,
                  applyImageRadius: false, // S'assurer que l'image prend tout l'espace
                  fit: BoxFit.fill, // Ajustement pour occuper tout l'espace
                ),
              )
          ).toList(),
          options: CarouselOptions(
            height: sliderHeight,
            viewportFraction: 1,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 7),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
            scrollDirection: Axis.horizontal,
          ),
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
                        ? Color(0xFFDFAC1B)
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
