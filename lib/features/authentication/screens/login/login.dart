import 'package:barbershpo_flutter/features/authentication/screens/login/widgets/login_form.dart';
import 'package:barbershpo_flutter/features/authentication/screens/login/widgets/login_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/styles/TSpacingStyle.dart';
import '../../../../common/widgets.buttons_signup/login_signup/form_divider.dart';
import '../../../../common/widgets.buttons_signup/login_signup/social_buttons.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              Column(
                children: [
                  /// -- Logo, Title & Sub-Title
                  TLoginHeader(),

                  /// -- Form
                  TLoginForm(),

                  /// -- Divider
                  TFormDivider(dividerText: TTexts.tContinue.capitalize!),

                  const SizedBox(
                    height: TSizes.spacetBtwSections,
                  ),

                  /// -- Footer
                  const TSocialButtons()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
