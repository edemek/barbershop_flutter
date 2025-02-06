import 'dart:convert';

import 'package:barbershpo_flutter/api_service/api_service_.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import 'package:http/http.dart' as http;

import '../../../../../utils/validators/validation_.dart';
import '../../../../personalization/screens/profile/profile.dart';
import '../verify_email.dart';

class TSignupClientForm extends StatefulWidget {
  TSignupClientForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  State<TSignupClientForm> createState() => _TSignupFormState();
}

class _TSignupFormState extends State<TSignupClientForm> {
  // Clé globale pour accéder au formulaire
  final _formKey = GlobalKey<FormState>();

  // Champs de saisie
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  // Pour contrôler la visibilité des mots de passe
  bool _obscureText = true;

  void sendOtp(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://votre-backend-url/api/send-otp'),
      body: {'phone_number': _phoneController.text},
    );

    if (response.statusCode == 200) {
      // Aller à l'écran de saisie de l'OTP
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              VerifyEmailScreen(PhoneNumber: _phoneController.text),
        ),
      );
    } else {
      // Afficher une erreur
      print('Erreur : ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                /// -- Prénoms
                child: TextFormField(
                  controller: _firstNameController,
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                  inputFormatters: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      // Applique la capitalisation à chaque mot
                      String formatted = newValue.text.split(' ').map((word) {
                        return word.isNotEmpty ? word[0].toUpperCase() + word.substring(1).toLowerCase() : '';
                      }).join(' ');

                      return newValue.copyWith(text: formatted);
                    }),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Prénoms obligatoire';
                    } else if (value.length < 3) {
                      return 'Le Nom doit contenir au moins 3 caractères';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwInputFields,
              ),
              Expanded(
                /// -- Nom
                child: TextFormField(
                  controller: _lastNameController,
                  expands: false,
                  inputFormatters: [
                    UpperCaseTextInputFormatter(), // Applique un formatage en majuscule
                  ],
                  decoration: const InputDecoration(
                    labelText: TTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nom obligatoire';
                    } else if (value.length < 4) {
                      return 'Le Nom doit contenir au moins 4 caractères';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),

          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),


          /// -- Email
          TextFormField(
            controller: _emailController,
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un mot de passe';
              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Adresse email invalide';
              }
              return null;
            },
          ),

          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          /// -- Phone Number
          TextFormField(
            controller: _phoneController,
            //keyboardType: TextInputType.phone,
            /*
            inputFormatters: [
              TogolesePhoneNumberFormatter(), // Formatter personnalisé
            ],*/
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: "Numéro de téléphone",
              hintText: "+22890909090",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre numéro de téléphone';
              }

              // Supprime les espaces pour la validation
              /*final cleanedValue =
                  value.replaceAll(' ', '').replaceAll('+228', '');

              // Validation pour s'assurer qu'il contient exactement 8 chiffres
              if (cleanedValue.length != 8 ||
                  !RegExp(r'^\d{8}$').hasMatch(cleanedValue)) {
                return 'Numéro de téléphone invalide';
              }*/

              return null;
            },
          ),

          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          /// -- Password
          TextFormField(
            controller: _passwordController,
            obscureText:
                _obscureText, // Utilisation de l'état pour masquer/afficher le texte
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.password_check),
              labelText: TTexts.password,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText
                      ? Iconsax.eye_slash
                      : Iconsax.eye, // Bascule entre icônes selon l'état
                ),
                onPressed: () {
                  setState(() {
                    _obscureText =
                        !_obscureText; // Change l'état de visibilité du mot de passe
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un mot de passe';
              } else if (value.length < 6) {
                return 'Le mot de passe doit contenir au moins 6 caractères';
              } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                return 'Le mot de passe doit contenir au moins une lettre majuscule';
              } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                return 'Le mot de passe doit contenir au moins un chiffre';
              } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                return 'Le mot de passe doit contenir au moins un caractère spécial';
              }
              return null;
            },
          ),

          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          /// -- Confirm the Password
          TextFormField(
            controller: _confirmPasswordController,
            obscureText:
                _obscureText, // Utilisation de l'état pour masquer/afficher le texte
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.password_check),
              labelText: TTexts.password,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText
                      ? Iconsax.eye_slash
                      : Iconsax.eye, // Bascule entre icônes selon l'état
                ),
                onPressed: () {
                  setState(() {
                    _obscureText =
                        !_obscureText; // Change l'état de visibilité du mot de passe
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un mot de passe';
              } else if (value.length < 6) {
                return 'Le mot de passe doit contenir au moins 6 caractères';
              } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                return 'Le mot de passe doit contenir au moins une lettre majuscule';
              } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                return 'Le mot de passe doit contenir au moins un chiffre';
              } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                return 'Le mot de passe doit contenir au moins un caractère spécial';
              } else if (_confirmPasswordController.text !=
                  _passwordController.text) {
                return 'Les mots de passes ne correspondent pas';
              }
              return null;
            },
          ),

          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          /// -- Termes & Conditions Checkbox
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(value: true, onChanged: (value) {}),
              ),
              const SizedBox(
                width: TSizes.spacetBtwItems,
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: TTexts.iAgreeTo,
                      style: Theme.of(context).textTheme.bodySmall),
                  /*TextSpan(
                    text: TTexts.privacyPolicy,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(
                            color: dark
                                ? TColors.white
                                : TColors.primary,
                            decoration: TextDecoration.underline,
                            decorationColor: dark
                                ? TColors.white
                                : TColors.primary),
                  ),
                  TextSpan(
                      text: TTexts.and,
                      style: Theme.of(context).textTheme.bodySmall),*/
                  TextSpan(
                    text: TTexts.termsOffUse,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: widget.dark ? TColors.white : TColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor:
                            widget.dark ? TColors.white : TColors.primary),
                  ),
                ]),
              ),
            ],
          ),

          const SizedBox(
            height: TSizes.spacetBtwSections,
          ),

          /// -- SignUp Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Mettre à jour les données utilisateur dans GetX
                  final userController = Get.find<UserController>();
                  userController.updateUser(
                    _firstNameController.text,
                    _lastNameController.text,
                    _emailController.text,
                    _phoneController.text,
                    _shopNameController.text,
                  );
                  final name = _firstNameController.text + " " + _lastNameController.text;
                  print("Nom complet1:"+name);
                  final reponse =  await ApiService.register(name, _phoneController.text,_emailController.text,_passwordController.text,_passwordController.text);
                  // Afficher un message de confirmation
                  if (reponse.statusCode == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Compte créé avec succès !')),
                    );

                    print("Nom complet : $name");
                    Get.to(() => ProfileScreen());
                  } else {
                    var responseBody = jsonDecode(reponse.body); // Décoder la réponse JSON
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Erreur lors de la création : ${responseBody['message']}")),
                    );
                  }

                  // Aller à la page de profil

                }
              },
              child: const Text(TTexts.signIn),
            ),
          ),

          /*
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Si la validation réussit
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Compte créé avec succès !')),
                    );
                    Get.to(() => VerifyEmailScreen(
                          phoneNumber: _phoneController.text,
                        ));
                  }
                },
                child: const Text(TTexts.signIn)
                /*
              onPressed: () => Get.to(() => VerifyEmailScreen()),
              child: const Text(TTexts.createAccount),
              */
                ),
          ),
          */
        ],
      ),
    );
  }
}
