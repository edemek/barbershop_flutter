import 'package:barbershpo_flutter/features/Manageservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../features/Reservation/reservationPage.dart';
import '../../features/Salon/screen/salon_coiffeur.dart';
import '../../features/authentication/screens/login/widgets/login_form.dart';
import '../../features/personalization/screens/profile/profile.dart';
import '../../utils/validators/validation_.dart';

class AccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    var _currentUser = {
      "name": userController.firstName.value
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Votre compte",
         // style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFDAA520),
        leading: PopupMenuButton<String>(
          icon: Icon(Icons.sort),
          onSelected: (String value) {
            if (value == 'Services') {
              Navigator.push(
                context,
                  MaterialPageRoute(builder: (context) =>  ManageServicesPage())
              ); // Remplacez '/services' par la route de votre page des services
            } else if (value == 'Reservations') {
             Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => ReservationDashboard())
             ); // Remplacez '/reservations' par la route de votre page des réservations
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'Services',
                child: Row(
                  children: [
                    Icon(Icons.design_services, color: Theme.of(context).hintColor),
                    SizedBox(width: 8),
                    Text('Services'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'Reservations',
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: Theme.of(context).hintColor),
                    SizedBox(width: 8),
                    Text('Reservations'),
                  ],
                ),
              ),
            ];
          },
        ),
      ),
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
                _buildMenuItem(context, Icons.person_outline, "Profile", () {
                  Get.to(() => ProfileScreen());
                  // Handle navigation
                }),
                _buildMenuItem(context, Icons.content_cut, "Salon", () {
                  // Handle navigation
                  Get.to(()=>SalonViewForm());
                }),
                _buildMenuItem(context, Icons.calendar_today, "Reservations", () {
                  Get.to(() => ReservationDashboard());

                }),
                /*
                _buildMenuItem(context, Icons.settings_outlined, "Settings", () {
                  // Handle navigation
                }),
                _buildMenuItem(context, Icons.logout, "Logout", () {
                  Get.to(() => TLoginForm());
                  // Handle logout
                }),*/
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
