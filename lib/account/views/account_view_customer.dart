import 'package:barbershpo_flutter/features/Manageservice.dart';
import 'package:barbershpo_flutter/features/settings/views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../features/Reservation/reservationPage.dart';
import '../../features/reservation_client/views/reservation_form.dart';
import '../../features/reservation_client/views/reservation_page.dart';
import '../../features/Salon/screen/salon_liste.dart';
import '../../features/authentication/screens/login/login.dart';
import '../../features/authentication/screens/login/widgets/login_form.dart';
import '../../features/experience_client/views/experience_form.dart';
import '../../features/experience_client/views/share_experience.dart';
import '../../features/personalization/screens/profile/profile.dart';
import '../../utils/validators/validation_.dart';

class AccountViewClient extends StatelessWidget {
  const AccountViewClient({super.key});
  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    // Dummy user data
    var _currentUser = {
      "name": userController.firstName.value
    };

    return Scaffold(

      body: ListView(
        children: [
          // Header with user info
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFDAA520),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                ),
                margin: EdgeInsets.only(bottom: 50),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        _currentUser["name"] ?? "",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,

                         // color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _currentUser["email"] ?? "",
                        //style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.black,
                child: _currentUser["avatar"] == null
                    ? Icon(Icons.person, size: 50, color: Colors.white)
                    : Image.network(_currentUser["avatar"] ?? ""),
              ),
            ],
          ),
          // Menu items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                _buildMenuItem(context, Icons.person_outline, "Profile", (){
                  Get.to(() => ProfileScreen());

                }
                  // Handle navigation
                ),
                /*
                _buildMenuItem(context, Icons.notifications_outlined, "Notifications", () {
                  // Handle navigation
                }),*/
                _buildMenuItem(context, Icons.settings_outlined, "Settings", () {
                  // Handle navigation
                  Get.to(() => SettingsView());
                }),
                _buildMenuItem(context, Icons.logout, "Deconnexion", () {
                  // Handle logout
                  userController.updateUser(null, null, null, null, null, null, null);
                  Get.to(() => LoginScreen());
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Text(label),
      onTap: onTap,
    );
  }
}
