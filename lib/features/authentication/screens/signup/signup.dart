import 'package:barbershpo_flutter/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// -- Title
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spacetBtwSections,
              ),

              /// -- Form
              TSignupForm(dark: dark),

              const SizedBox(
                height: TSizes.spacetBtwSections,
              ),

              /// -- Divider
              TFormDivider(dividerText: TTexts.tContinue.capitalize!),

              const SizedBox(
                height: TSizes.spacetBtwSections,
              ),

              /// -- Divider
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
