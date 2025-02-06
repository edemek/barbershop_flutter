import 'package:barbershpo_flutter/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:barbershpo_flutter/utils/constants/sizes.dart';
import 'package:barbershpo_flutter/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/validators/validation_.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// -- Heading
            Text(
              TTexts.forgotPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: TSizes.spacetBtwItems,
            ),
            Text(
              TTexts.forgotPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),

            const SizedBox(
              height: TSizes.spacetBtwSections * 2,
            ),

            /// -- Text fiels
            //TextFormField( decoration: const InputDecoration(labelText: TTexts.phoneNumber, prefixIcon: Icon(Iconsax.call)),  ),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                TogolesePhoneNumberFormatter(), // Formatter personnalisé
              ],
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.call),
                labelText: "Numéro de téléphone",
                hintText: "+228 90 90 90 90",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre numéro de téléphone';
                }

                final cleanedValue =
                    value.replaceAll(' ', '').replaceAll('+228', '');

                if (cleanedValue.length != 8 ||
                    !RegExp(r'^\d{8}$').hasMatch(cleanedValue)) {
                  return 'Numéro de téléphone invalide';
                }
                return null;
              },
            ),

            const SizedBox(
              height: TSizes.spacetBtwSections,
            ),

            /// -- Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.off(() => ResetPassword()),
                child: const Text(TTexts.submit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
