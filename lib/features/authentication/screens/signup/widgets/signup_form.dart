import 'package:barbershpo_flutter/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import 'package:http/http.dart' as http;

import '../../../../../utils/validators/validation.dart';
import '../verify_email.dart';

class TSignupForm extends StatefulWidget {
  const TSignupForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  State<TSignupForm> createState() => _TSignupFormState();
}

class _TSignupFormState extends State<TSignupForm> {
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

  // Contrôleur d'authentification
  final AuthController _authController = Get.find<AuthController>();

  // Pour contrôler la visibilité des mots de passe
  bool _obscureText = true;

  // Fonction pour envoyer un OTP au numéro de téléphone
  void sendOtp(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://172.20.10.2:8000/api/send-otp'),
      body: {'phone_number': _phoneController.text},
    );

    if (response.statusCode == 200) {
      // Aller à l'écran de saisie de l'OTP
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              VerifyPhoneScreen(phoneNumber: _phoneController.text),
        ),
      );
    } else {
      // Afficher une erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Ligne contenant les champs "Prénoms" et "Nom"
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                  inputFormatters: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      // Capitalisation automatique des mots
                      String formatted = newValue.text.split(' ').map((word) {
                        return word.isNotEmpty
                            ? word[0].toUpperCase() +
                                word.substring(1).toLowerCase()
                            : '';
                      }).join(' ');
                      return newValue.copyWith(text: formatted);
                    }),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Prénoms obligatoire';
                    } else if (value.length < 3) {
                      return 'Le prénom doit contenir au moins 3 caractères';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: TTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                  inputFormatters: [
                    UpperCaseTextInputFormatter(), // Formatage en majuscule
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nom obligatoire';
                    } else if (value.length < 4) {
                      return 'Le nom doit contenir au moins 4 caractères';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Champ "Nom de la boutique"
          TextFormField(
            controller: _shopNameController,
            decoration: const InputDecoration(
              labelText: TTexts.shopName,
              prefixIcon: Icon(Iconsax.home),
            ),
            inputFormatters: [
              TextInputFormatter.withFunction((oldValue, newValue) {
                // Capitalisation automatique des mots
                String formatted = newValue.text.split(' ').map((word) {
                  return word.isNotEmpty
                      ? word[0].toUpperCase() + word.substring(1).toLowerCase()
                      : '';
                }).join(' ');
                return newValue.copyWith(text: formatted);
              }),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer le nom de votre boutique';
              } else if (value.length < 3) {
                return 'Le nom doit contenir au moins 3 caractères';
              }
              return null;
            },
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Champ "Email"
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.message),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un email';
              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Adresse email invalide';
              }
              return null;
            },
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Champ "Numéro de téléphone"
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

          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Champ "Mot de passe"
          TextFormField(
            controller: _passwordController,
            obscureText: _obscureText,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.password_check),
              labelText: TTexts.password,
              suffixIcon: IconButton(
                icon: Icon(_obscureText ? Iconsax.eye_slash : Iconsax.eye),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
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
              } else if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
                return 'Le mot de passe doit contenir au moins un caractère spécial';
              }
              return null;
            },
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Champ "Confirmer le mot de passe"
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureText,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.password_check),
              labelText: TTexts.confirmPassword,
              suffixIcon: IconButton(
                icon: Icon(_obscureText ? Iconsax.eye_slash : Iconsax.eye),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez confirmer le mot de passe';
              } else if (value != _passwordController.text) {
                return 'Les mots de passe ne correspondent pas';
              }
              return null;
            },
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Checkbox des termes et conditions
          Row(
            children: [
              Checkbox(
                value: true,
                onChanged: (value) {
                  // Logique pour gérer l'état de la case à cocher
                },
              ),
              const SizedBox(width: TSizes.spacetBtwItems),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: TTexts.iAgreeTo,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: TTexts.termsOffUse,
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color:
                                  widget.dark ? TColors.white : TColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Bouton d'inscription
          SizedBox(
            width: double.infinity,
            child: Obx(() {
              if (_authController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ElevatedButton(
                  onPressed: () => Get.to(() =>
                      VerifyPhoneScreen(phoneNumber: _phoneController.text)),
                  /*{
                    if (_formKey.currentState!.validate()) {
                      _authController.register(
                        '${_firstNameController.text} ${_lastNameController.text}',
                        _phoneController.text,
                        _passwordController.text,
                        _confirmPasswordController.text,
                      );

                      // Mise à jour des données utilisateur
                      final userController = Get.find<UserController>();
                      userController.updateUser(
                        _firstNameController.text,
                        _lastNameController.text,
                        _emailController.text,
                        _phoneController.text,
                        _shopNameController.text,
                      );

                      // Affichage du message de succès
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Compte créé avec succès !')),
                      );

                      // Redirection vers la page de profil
                      Get.to(() => ProfileScreen());
                    }
                  },*/
                  child: const Text(TTexts.createAccount),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}



/*
import 'package:barbershpo_flutter/controllers/auth_controller.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import 'package:http/http.dart' as http;

import '../../../../../utils/validators/validation.dart';
import '../../../../personalization/screens/profile/profile.dart';
import '../verify_email.dart';

class TSignupForm extends StatefulWidget {
  TSignupForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  State<TSignupForm> createState() => _TSignupFormState();
}

class _TSignupFormState extends State<TSignupForm> {
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
  final AuthController _authController = Get.find<AuthController>();

  // Pour contrôler la visibilité des mots de passe
  bool _obscureText = true;

  void sendOtp(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://172.20.10.2:8000/api/send-otp'),
      body: {'phone_number': _phoneController.text},
    );

    if (response.statusCode == 200) {
      // Aller à l'écran de saisie de l'OTP
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              VerifyEmailScreen(phoneNumber: _phoneController.text),
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
                        return word.isNotEmpty
                            ? word[0].toUpperCase() +
                                word.substring(1).toLowerCase()
                            : '';
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

          /// -- ShopName
          TextFormField(
            controller: _shopNameController,
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.shopName,
              prefixIcon: Icon(Iconsax.home),
            ),
            inputFormatters: [
              TextInputFormatter.withFunction((oldValue, newValue) {
                // Applique la capitalisation à chaque mot
                String formatted = newValue.text.split(' ').map((word) {
                  return word.isNotEmpty
                      ? word[0].toUpperCase() + word.substring(1).toLowerCase()
                      : '';
                }).join(' ');
                return newValue.copyWith(text: formatted);
              }),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer le Nom de votre boutique';
              } else if (value.length < 3) {
                return 'Le Nom doit contenir au moins 3 caractères';
              }
              return null;
            },
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
              prefixIcon: Icon(Iconsax.message),
            ),
            /*validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un email';
              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Adresse email invalide';
              }
              return null;
            },*/
          ),

          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          /// -- Phone Number
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

              // Supprime les espaces pour la validation
              final cleanedValue =
                  value.replaceAll(' ', '').replaceAll('+228', '');

              // Validation pour s'assurer qu'il contient exactement 8 chiffres
              if (cleanedValue.length != 8 ||
                  !RegExp(r'^\d{8}$').hasMatch(cleanedValue)) {
                return 'Numéro de téléphone invalide';
              }

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
                return 'Veuillez confirner le mot de passe';
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

          const SizedBox(height: TSizes.spaceBtwInputFields),

          Obx(() {
            if (_authController.error.isNotEmpty) {
              return Text(
                _authController.error.value,
                style: TextStyle(color: Colors.red),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),

          const SizedBox(
            height: TSizes.spacetBtwSections,
          ),

          /// -- SignUp Button
          SizedBox(
            width: double.infinity,
            child: Obx(() {
              if (_authController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _authController.register(
                          '${_firstNameController.text} ${_lastNameController.text}',
                          _phoneController.text,
                          _passwordController.text,
                          _confirmPasswordController.text);

                      // Mettre à jour les données utilisateur dans GetX

                      final userController = Get.find<UserController>();
                      userController.updateUser(
                        _firstNameController.text,
                        _lastNameController.text,
                        _emailController.text,
                        _phoneController.text,
                        _shopNameController.text,
                      );

                      // Afficher un message de confirmation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Compte créé avec succès !')),
                      );
                      // Aller à la page de profil
                      Get.to(() => ProfileScreen());
                    }
                  },
                  child: const Text(TTexts.createAccount),
                );
              }
            }),
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
*/