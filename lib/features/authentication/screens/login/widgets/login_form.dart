import 'dart:convert';

import 'package:barbershpo_flutter/account/views/account_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import '../../../../../api_service/api_service_.dart';
import '../../../../../navigation_menu.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation_.dart';
import '../../../../forgot_password_page.dart';
import '../../../../support.dart';
import '../../../../verification.dart';
import '../../signup/signup.dart';
import '../../signup/signup_choice.dart';
import '../../../../../controllers/auth_controller.dart';
import '../../signup/verify_email.dart';

class TLoginForm extends StatefulWidget {
  TLoginForm({super.key});

  @override
  _TLoginFormState createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {
  // Clé globale pour accéder au formulaire
  final _formKey = GlobalKey<FormState>();
  final TextEditingController tokenTaker = TextEditingController();
  final TextEditingController Role = TextEditingController();
  // Champs de saisie
  final TextEditingController _PhoneController = TextEditingController();
  // final TextEditingController _NomController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode =
      FocusNode(); // création d'une instance focus sur _email
  bool _obscureText = true; // Contrôle l'état du texte masqué

  //compteur d'erruer
  int nbError = 0;

  /// Fonction pour envoyer un OTP
  void sendOtp(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/send-otp'),
        body: {'phone_number': _PhoneController.text},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Code OTP envoyé avec succès !'),
            duration: Duration(seconds: 3),
          ),
        );

        // Aller à l'écran de saisie de l'OTP
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VerifyEmailScreen(PhoneNumber: _PhoneController.text),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Erreur lors de l\'envoi du code OTP : ${response.body}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 50),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Une erreur est survenue : $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 50),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // controller.loginFormKey = new GlobalKey<FormState>();
    final controller = Get.find<AuthController>();
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spacetBtwSections),
        child: Column(
          children: [
            /// -- Numéro de Téléphone/email
            TextFormField(
              focusNode: _emailFocusNode,
              // controller: _PhoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                TogolesePhoneNumberFormatter(),
                NoSpaceFormatter()
              ],
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: "Numéro de téléphone",
                hintText: "+228 90 90 90 90",
              ),
              // onChanged: (value) {},
              initialValue: controller.currentUser.value.email,
              onSaved: (value) => controller.currentUser.value.phoneNumber = value,
                        
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

            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// -- Mot de passe
            TextFormField(
              // controller: _passwordController,
              obscureText: _obscureText,
              onSaved: (value) => controller.currentUser.value.password = value,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                labelText: TTexts.password,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Iconsax.eye_slash : Iconsax.eye,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              //code pour valider le mot de passe
              // //validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Veuillez entrer un mot de passe';
              //   } else if (value.length < 6) {
              //     return 'Le mot de passe doit contenir au moins 6 caractères';
              //   } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
              //     return 'Le mot de passe doit contenir au moins une lettre majuscule';
              //   } else if (!RegExp(r'[0-9]').hasMatch(value)) {
              //     return 'Le mot de passe doit contenir au moins un chiffre';
              //   } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
              //     return 'Le mot de passe doit contenir au moins un caractère spécial';
              //   }
              //   return null;
              // },
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields / 2),
            //
            /*
            Align(
              alignment: Alignment.centerLeft, // Aligne le contenu à gauche
              child: Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      // Gestion du changement de l'état de la checkbox
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  const Text(TTexts.ConnectAsBarber),
                ],
              ),
            ),*/
            /// -- Remember Me & Forget Password
            ///
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (value) {}),
                        const Text(TTexts.remenderMe),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage()));
                      },
                      child: const Text(TTexts.forgotPassword),
                    ),
                  ],
                ),

                const SizedBox(height: 2), // Espacement entre les widgets
                Align(
                  alignment: Alignment.centerLeft, // Aligne le bouton à gauche
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SupportClientPage()));

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Bouton de support client cliqué"),
                          elevation: 6,
                          duration: Duration(seconds: 2), // Durée d'affichage
                        ),
                      );
                    },
                    child: const Text(TTexts.clientSupport),
                  ),
                ),
              ],
            ),

            const SizedBox(height: TSizes.spacetBtwSections),

            /// -- Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text(TTexts.signIn),
                onPressed: () {
                  controller.login();
                 
                },
              ),
            ),

            const SizedBox(height: TSizes.spacetBtwItems),

            /// -- Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() =>
                    AccountTypeSelection()), //defiler entre les pages en utilisant la classe Get.to
                child: const Text(TTexts.createAccount),
              ),
            ),

            const SizedBox(height: TSizes.spacetBtwItems),
          ],
        ),
      ),
    );
  }
}
