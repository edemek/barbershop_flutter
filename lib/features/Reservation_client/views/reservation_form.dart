import 'package:flutter/material.dart';
import 'package:barbershpo_flutter/features/reservation_client/views/reservation_liste.dart';
import 'package:barbershpo_flutter/features/reservation_client/views/reservation_page.dart';

import '../../support.dart';


class ReservationHomeScreen extends StatefulWidget {
  static final List<Map<String, String>> reservationListe = []; // Liste des réservations

  @override
  _ReservationHomeScreenState createState() => _ReservationHomeScreenState();
}

class _ReservationHomeScreenState extends State<ReservationHomeScreen> {

  int _selectedIndex = 0; // Index de la page sélectionnée
  final List<Widget> _pages = [
    ReservationPage(), // Page principale de réservation
    ReservationListePage(ReservationHomeScreen.reservationListe), // Page affichant la liste des réservations
    SupportClientPage(), // Page de support client
  ];

  // Méthode de gestion de l'index sélectionné du BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Met à jour la page sélectionnée
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Affiche la page en fonction de l'index sélectionné
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Index actuel sélectionné
        onTap: _onItemTapped, // Change la page quand un item est tapé
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Réserver'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Mes Réservations'),
          BottomNavigationBarItem(icon: Icon(Icons.support), label: 'Support'),
        ],
      ),
    );
  }
}
