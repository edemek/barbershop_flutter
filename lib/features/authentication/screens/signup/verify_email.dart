import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:http/http.dart' as http;

import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../personalization/screens/profile/profile.dart';
import '../login/login.dart';

class VerifyPhoneScreen extends StatelessWidget {
  final String phoneNumber;

  const VerifyPhoneScreen({super.key, required this.phoneNumber});

  Future<void> verifyOtp(String otp, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://127.0.0.1:8000/api/verify-otp'), // Remplace par ton URL réelle
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'phone_number': phoneNumber, 'otp': otp},
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        //String message = responseBody['message'] ?? 'OTP vérifié avec succès.';
        Get.to(() => SuccessScreen(
              image: TImages.staticSuccessIllustration,
              title: TTexts.yourAccountCreatedTitle,
              subtitle: TTexts.yourAccountCreatedSubTitle,
              onPressed: () => Get.to(() => const ProfileScreen()),
            ));
      } else {
        String errorMessage =
            responseBody['error'] ?? 'La vérification a échoué.';
        Get.snackbar(
          'Erreur',
          errorMessage,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Une erreur s\'est produite : $e',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  Future<void> resendOtp(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://127.0.0.1:8000/api/resend-otp'), // Remplace par ton URL réelle
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'phone_number': phoneNumber},
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        String message =
            responseBody['message'] ?? 'Un nouvel OTP a été envoyé.';
        Get.snackbar(
          'Succès',
          message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        String errorMessage =
            responseBody['error'] ?? 'Impossible de renvoyer l\'OTP.';
        Get.snackbar(
          'Erreur',
          errorMessage,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Une erreur s\'est produite : $e',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => const LoginScreen()),
            icon: const Icon(CupertinoIcons.clear),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Image(
                height: 150,
                image: AssetImage(
                    dark ? TImages.lightAppLogo : TImages.darkAppLogo),
              ),
              const SizedBox(height: TSizes.spacetBtwSections),
              Text(
                TTexts.confirmPhoneNumber,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spacetBtwItems),
              Text(
                'Nous vous avons envoyé un message au numéro :',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                phoneNumber,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spacetBtwSections),
              OtpTextField(
                numberOfFields: 4,
                borderColor: Colors.blue,
                showFieldAsBox: true,
                onSubmit: (otp) => verifyOtp(otp, context),
              ),
              const SizedBox(height: TSizes.spacetBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Action déclenchée après avoir soumis le code OTP
                    Get.snackbar(
                      'Vérification',
                      'Veuillez entrer le code OTP ci-dessus.',
                      backgroundColor: Colors.orange,
                      colorText: Colors.white,
                    );
                  },
                  child: const Text(TTexts.otpVerification),
                ),
              ),
              const SizedBox(height: TSizes.spacetBtwItems),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => resendOtp(context),
                  child: const Text(TTexts.resendSms),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
