import 'package:barbershpo_flutter/features/authentication/screens/signup/signup.dart';
import 'package:barbershpo_flutter/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/validators/validation_.dart';


class AccountTypeSelection extends StatelessWidget {
  // Définition des couleurs principales (les mêmes que précédemment)
  static const Color primaryGold = Color(0xFFDAA520);
  static const Color backgroundBlack = Color(0xFF1A1A1A);
  static const Color softWhite = Color(0xFFF5F5F5);
  static const Color darkGrey = Color(0xFF2A2A2A);
  bool isClient = false;
  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    return Scaffold(
      backgroundColor: backgroundBlack,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [darkGrey, backgroundBlack],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Choisissez le type de compte\nque vous souhaitez créer",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: softWhite,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),

                SizedBox(height: 50),
                _buildAccountCard(
                  context: context,
                  title: "Compte Coiffeur",
                  icon: Icons.content_cut,
                  description: "Créez votre profil professionnel et gérez votre salon",
                  onTap: () {
                    // Navigation vers l'inscription coiffeur

                        userController.updateUser(
                        null,
                        null,
                        null,
                        null,
                          null

                        );
                    Get.to(()=>SignupScreen());
                    print("Navigation vers inscription en tant que coiffeur");
                  },
                ),
                SizedBox(height: 24),
                _buildAccountCard(
                  context: context,
                  title: "Compte Client",
                  icon: Icons.person,
                  description: "Découvrez et partagez vos expériences",
                  onTap: () {
                    // Navigation vers l'inscription client

                      userController.updateUser(
                          null,
                          null,
                          null,
                          null,
                          null,

                      );
                      Get.to(()=>SignupScreen());
                      print("Navigation vers inscription en tant que client");
                    }

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAccountCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required String description,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: darkGrey,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: primaryGold.withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: backgroundBlack,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: primaryGold,
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: primaryGold,
                    size: 30,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: softWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        description,
                        style: TextStyle(
                          color: softWhite.withOpacity(0.7),
                          fontSize: 14,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: primaryGold,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}