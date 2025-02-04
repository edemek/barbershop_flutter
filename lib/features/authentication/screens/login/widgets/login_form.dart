import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import '../../../../../api_service/api_service.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../../forgot_password_page.dart';
import '../../../../support.dart';
import '../../../../verification.dart';
import '../../signup/signup.dart';
import '../../signup/signup_choice.dart';
import '../../signup/verify_email.dart';

class TLoginForm extends StatefulWidget {
  TLoginForm({super.key});

  @override
  _TLoginFormState createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {
  // Clé globale pour accéder au formulaire
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  final TextEditingController tokenTaker = TextEditingController();
  // Champs de saisie
  final TextEditingController _emailOrPhoneController  = TextEditingController();
  final TextEditingController _NomController  = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode(); // création d'une instance focus sur _email
  bool _obscureText = true; // Contrôle l'état du texte masqué

  //compteur d'erruer
  int nbError = 0;
  /// Fonction pour envoyer un OTP
  void sendOtp(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/send-otp'),
        body: {'phone_number': _emailOrPhoneController.text},
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
                VerifyEmailScreen(emailOrPhoneNumber: _emailOrPhoneController.text),
          ),

        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de l\'envoi du code OTP : ${response.body}'),
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
    final userController = Get.find<UserController>();
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spacetBtwSections),
        child: Column(
          children: [
            /// -- Numéro de Téléphone/email
            TextFormField(
              focusNode: _emailFocusNode, // Liaison du FocusNode ici
              controller: _emailOrPhoneController,
              keyboardType: TextInputType.emailAddress,
              //inputFormatters: [
                //TogoleseemailOrPhoneNumberFormatter(), // Formatter personnalisé
              //],
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: "Numéro de téléphone/Email",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre numéro de téléphone ou votre email';
                }
                  // fonctionalité mis en attente
                /*final cleanedValue =
                //value.replaceAll(' ', '').replaceAll('+228', '');

                if (cleanedValue.length != 8 ||
                    !RegExp(r'^\d{8}$').hasMatch(cleanedValue)) {
                  return 'Numéro de téléphone invalide';
                }

                return null;*/
              },
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// -- Mot de passe
            TextFormField(
              controller: _passwordController,
              obscureText: _obscureText,
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
            ),
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
                        Navigator.push(context,
                           MaterialPageRoute(builder: (context)=>ForgotPasswordPage())
                            );



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
                      context, MaterialPageRoute(builder: (context)=>SupportClientPage()));

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
                onPressed: () async {
                  /*if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('OTP Envoié !'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                    sendOtp(context);

                  }

                  //simulation d'identifiant
                  final String usernameOremail = "test";
                  final String password = "test";
                  final String usernameOremail_clt = "client";
                  final String password_clt = "client";*/

                  if (_emailOrPhoneController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty)
                      {
                        Get.put(UserController());
                      final response = await ApiService.login(_emailOrPhoneController.text, _passwordController.text);

                      if (response.statusCode == 200) {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) =>
                      VerificationPage(
                      emailOrPhone: _emailOrPhoneController
                          .text,isChecked: isChecked,)),
                      );print("Contenu : ${response.body.toString()}");
                      final Map<String, dynamic> responseData = jsonDecode(response.body);
                      if (responseData.containsKey("data")) {
                      String name = responseData["data"]["name"];
                      String token = responseData["data"]["api_token"];
                      print("token de l'utilisateur:$token");
                      _NomController.text = name; // ✅ Mise à jour du TextEditingController
                      tokenTaker.text = token;
                      print("token de l'utilisateur recuperé:$token");
                      userController.updateUser(
                         _NomController.text,
                          null,
                        null,
                        null,
                        null,
                        tokenTaker.text,
                      );
                      print("UserController token: ${userController.UToken}");
                      print("UserController token value: ${userController.UToken.value}");
                      print("Nom de l'utilisateur mis à jour : ${_NomController.text}");
                      } else {
                      print("Erreur : 'user' non trouvé dans la réponse.");
                      }

                      }else{
                        var responseBody = jsonDecode(response.body); // Décoder la réponse JSON
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    "Erreur de connexion : ${responseBody['message']}",

                                ),
                            ));
                        print("Erreur de connexion : ${response.body.toString()}");
                                nbError++;
                        print("nombre d'erreur:" + nbError.toString());

                        _emailOrPhoneController.clear();
                        _passwordController.clear();

                        if(nbError == 5){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Vous avez essayer à plus de 5 tentaives, votre compte est momentanément suspendu! contacter le service client pour reinitialisation"),
                            )
                        );
                      }
                      //mettre le focus sur l'email
                      FocusScope.of(context).requestFocus(_emailFocusNode);




                    }
                    // Simulation de connexion réussie

                  }else{
                    return ;
                  };

                },
                  child: const Text(TTexts.signIn),
              ),
            ),

            const SizedBox(height: TSizes.spacetBtwItems),

            /// -- Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() =>  AccountTypeSelection()),//defiler entre les pages en utilisant la classe Get.to
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

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../../personalization/screens/profile/profile.dart';
import '../../signup/signup.dart';
import '../../signup/verify_email.dart';
import '../../signup/widgets/signup_form.dart';

class TLoginForm extends StatefulWidget {
  TLoginForm({super.key});

  @override
  _TLoginFormState createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {
  // Clé globale pour accéder au formulaire
  final _formKey = GlobalKey<FormState>();

  // Champs de saisie
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true; // Contrôle l'état du texte masqué

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
              VerifyEmailScreen(emailOrPhoneNumber: _phoneController.text),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spacetBtwSections),
        child: Column(
          children: [
            /// -- Numéro de Téléphone
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                TogoleseemailOrPhoneNumberFormatter(), // Formatter personnalisé
              ],
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
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

            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// -- Mot de passe
            TextFormField(
              controller: _passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                labelText: TTexts.password,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Iconsax.eye_slash : Iconsax.eye,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText; // Bascule entre masqué et visible
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

            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            /// -- Remember Me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Remember Me
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(TTexts.remenderMe),
                  ],
                ),

                /// Forget Password
                TextButton(
                  onPressed: () {},
                  child: const Text(TTexts.forgotPassword),
                ),
              ],
            ),

            const SizedBox(height: TSizes.spacetBtwSections),

            /// -- Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Si la validation réussit
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Connexion faite avec succès !')),
                    );
                    sendOtp(context);
                    Get.to(() => ProfileScreen());
                  }
                },
                child: const Text(TTexts.signIn),
              ),
            ),
            const SizedBox(height: TSizes.spacetBtwItems),

            /// -- Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignupScreen()),
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

*/