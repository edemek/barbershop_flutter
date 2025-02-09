
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_routes.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import 'package:http/http.dart' as http;
import '../../../../../utils/validators/validation_.dart';
import '../verify_email.dart';
import '../../../../../controllers/auth_controller.dart';

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
  // final _formKey = GlobalKey<FormState>();

  // Champs de saisie
  final TextEditingController _phoneController = TextEditingController();
  String? _confirmPasswordValue; //
  // Pour contrôler la visibilité des mots de passe
  bool _obscureText = true;

   @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

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
    final controller = Get.find<AuthController>();

    return Form(
      key: controller.registerFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                /// -- Prénoms
                child: TextFormField(
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
                  initialValue: controller.currentUser.value.name,
                  onSaved: (value) => controller.currentUser.value.name = value,
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
                  expands: false,
                  inputFormatters: [
                    UpperCaseTextInputFormatter(), // Applique un formatage en majuscule
                  ],
                  decoration: const InputDecoration(
                    labelText: TTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                  initialValue: controller.currentUser.value.name,
                  onSaved: (value) => controller.currentUser.value.name = value,
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
          // TextFormField(
          //   expands: false,
          //   decoration: const InputDecoration(
          //     labelText: TTexts.email,
          //     prefixIcon: Icon(Iconsax.direct),
          //   ),
          //   initialValue: controller.currentUser.value.email,
          //   onSaved: (value) => controller.currentUser.value.email = value,
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Veuillez entrer un mot de passe';
          //     } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          //       return 'Adresse email invalide';
          //     }
          //     return null;
          //   },
          // ),

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
            initialValue: controller.currentUser.value.phoneNumber,
            onSaved: (value) =>
                controller.currentUser.value.phoneNumber = value,

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
            initialValue: controller.currentUser.value.password,
            onSaved: (value) => controller.currentUser.value.password = value,

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
            onSaved: (value) => _confirmPasswordValue = value,
            validator: (value) {
              print(value);
              print(controller.currentUser.value.password);
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
              onPressed: () {
                if (controller.registerFormKey.currentState!.validate()) {
                 controller.registerFormKey.currentState!.save();

                  // After saving, compare password and confirm password
                  if (controller.currentUser.value.password != _confirmPasswordValue) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Passwords do not match.")),
                    );
                    return;
                  }

                  // If passwords match, proceed with further actions (e.g., saving)
                  controller.register();
                  Get.offAllNamed(Routes.PHONE_VERIFICATION , arguments: {
                    'emailOrPhone': 'user@example.com',
                    'role': 'customer',
                  },);
                  // Add your logic here to save the data or navigate
                }
               
                // controller.register(name, email, password, passwordConfirmation);
                // if (_formKey.currentState!.validate()) {
                //   // Mettre à jour les données utilisateur dans GetX
                //   final userController = Get.find<UserController>();
                //   userController.updateUser(
                //     _firstNameController.text,
                //     _lastNameController.text,
                //     _emailController.text,
                //     _phoneController.text,
                //     _shopNameController.text,
                //     null,
                //     userController.UserRole.value,
                //   );

                //   final name = _firstNameController.text + " " + _lastNameController.text;
                //   print("Nom complet1:"+name);
                //   var  reponse;
                //   if(userController.UserRole.value == "customer"){
                //     reponse =  await ApiService.register_client(name, _phoneController.text,_emailController.text,_passwordController.text,_passwordController.text);
                //   }else{
                //     reponse =  await ApiService.register_salon_owner(name, _phoneController.text,_emailController.text,_passwordController.text,_passwordController.text);
                //   }

                //   // Afficher un message de confirmation
                //   if (reponse.statusCode == 200) {

                //     ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(content: Text('Compte créé avec succès !')),
                //     );

                //     print("Nom complet : $name");
                //     Get.to(() => LoginScreen());
                //   } else {
                //     var responseBody = jsonDecode(reponse.body); // Décoder la réponse JSON
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(content: Text("Erreur lors de la création : ${responseBody['message']}")),
                //     );
                //   }

                //   // Aller à la page de profil

                // }
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
