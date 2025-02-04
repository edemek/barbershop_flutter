import 'package:barbershpo_flutter/features/experience_client/views/share_experience.dart';
import 'package:flutter/material.dart';

import '../../rating/rating_view.dart';
import '../../support.dart';
import 'experience_list.dart';


class ExperienceHomeScreen extends StatefulWidget {
  static final List<Map<String, String>> reservationListe = []; // Liste des réservations

  @override
  _ExperienceHomeScreenState createState() => _ExperienceHomeScreenState();
}

class _ExperienceHomeScreenState extends State<ExperienceHomeScreen> {

  int _selectedIndex = 0; // Index de la page sélectionnée
  final List<Widget> _pages = [
    ShareExperience(), // Page principale de réservation
    ExperienceList(),// Page affichant la liste des réservations
    //RatingView()
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
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Partager votre expérience"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Voir les experiences des autres'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Donner vos avis '),
        ],
      ),
    );
  }
}
