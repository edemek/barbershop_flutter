import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../../../common/widgets.buttons_signup/success_screen/success_screen.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import 'package:http/http.dart' as http;

import '../../../personalization/screens/profile/profile.dart';
import '../login/login.dart';

class VerifyEmailScreen extends StatelessWidget {

  final String emailOrPhoneNumber;

  VerifyEmailScreen({required this.emailOrPhoneNumber});

  void verifyOtp(String otp, BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://votre-backend-url/api/verify-otp'),
      body: {
        'phone_number': emailOrPhoneNumber,
        'otp': otp,
      },
    );

    if (response.statusCode == 200) {
      // OTP vérifié avec succès
      print('OTP vérifié avec succès');
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Succès'),
          content: Text('OTP vérifié avec succès.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Échec de la vérification
      print('Erreur : ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.offAll(() => const LoginScreen()),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// -- Image
              Image(
                image: AssetImage(TImages.deliveredEmailIllustration),
                width: THelperFunctions.screenWidth() * 0.6,
              ),

              const SizedBox(
                height: TSizes.spacetBtwSections,
              ),

              Center(
                child: OtpTextField(
                  numberOfFields: 6,
                  borderColor: Colors.blue,
                  onSubmit: (otp) => verifyOtp(otp, context),
                ),
              ),

              const SizedBox(
                height: TSizes.spacetBtwItems,
              ),

              /// -- Title & SubTitle
              Text(
                TTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                height: TSizes.spacetBtwItems,
              ),

              Text(
                'bhelpconsultion@gmail.com',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                height: TSizes.spacetBtwItems,
              ),
              Text(
                TTexts.confirmEmailSubtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                height: TSizes.spacetBtwItems,
              ),

              /// -- Buttons returne to Login
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => SuccessScreen(
                        image: TImages.staticSuccessIllustration,
                        title: TTexts.yourAccountCreatedTitle,
                        subtitle: TTexts.yourAccountCreatedSubTitle,
                        onPressed: () => Get.to(() => const ProfileScreen()),
                      )),
                  child: const Text(TTexts.tContinue),
                ),
              ),

              const SizedBox(
                height: TSizes.spacetBtwItems,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(TTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
