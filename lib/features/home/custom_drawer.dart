import 'package:barbershpo_flutter/utils/validators/validation_.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../navigation_menu.dart';
import '../authentication/screens/login/login.dart';
import '../experience_client/views/experience_form.dart';

class ElegantMenu extends StatelessWidget {
  const ElegantMenu({Key? key}) : super(key: key);


  void _navigateTo(BuildContext context, String routeName) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var userController = Get.find<UserController>();
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Color(0xFFDFAC1B),
                    Color(0xFFFFE859),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -30,
                    top: -30,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.withOpacity(0.2),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cut_rounded,
                          size: 50,
                          color: Colors.black87,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Menu',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildMenuItem(
              context: context,
              icon: Icons.home,
              title: 'Accueil',
              onTap: () => _navigateTo(context, '/accueil'),
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.calendar_today,
              title: 'Reservation',
              onTap: () {
                if (userController.UToken == '') {
                  Navigator.of(context).pop();
                  Get.to(() => LoginScreen());
                  return; // Empêche l'exécution du reste du code
                }

                Navigator.of(context).pop();
                final navigationController = Get.find<NavigationController>();
                navigationController.selectedIndex.value = 1;
              },
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.category,
              title: 'Catégories',
              onTap: () => _navigateTo(context, '/categories'),
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.star,
              title: 'Experience',
              onTap: () {
                  if (userController.UToken == '') {
                  Navigator.of(context).pop();
                  Get.to(() => LoginScreen());
                  return; // Empêche l'exécution du reste du code
              }
                  }
            ),
            _buildMenuItem(
              context: context,
              icon: Icons.share,
              title: 'Partager mon code',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                // gradient: LinearGradient(
                //   colors: [
                //     Colors.white,
                //     Colors.black,
                //   ],
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                // ),
              ),
              child: Column(
                children: [
                  // Icon(
                  //   Icons.content_cut,
                  //   color: Colors.blue.shade800,
                  //   size: 24,
                  // ),
                  const SizedBox(height: 8),
                  Text(
                    'CHARM',
                    style: TextStyle(
                      color: Color(0xFFDFAC1B),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: Color(0xFFDFAC1B),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
                // const Spacer(),
                // Icon(
                //   Icons.arrow_forward_ios,
                //   color: Colors.blue.shade200,
                //   size: 16,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
