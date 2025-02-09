import 'package:barbershpo_flutter/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:barbershpo_flutter/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:barbershpo_flutter/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:barbershpo_flutter/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controllers/onboard_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              const OnBoardingPage(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              const OnBoardingPage(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              const OnBoardingPage(
                image: TImages.onBoardingImage3,
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),

          /// -- Skip Button
          const OnBoardingSkip(),

          /// -- Dot Navigation SmoothpageIndicator
          const OnBoardingDotNavigation(),

          /// -- Circular Button
          const OnboardingNextButton(),
        ],
      ),
    );
  }
}
