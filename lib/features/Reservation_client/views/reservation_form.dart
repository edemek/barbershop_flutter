import 'package:barbershpo_flutter/features/Reservation_client/views/reservation_liste.dart';
import 'package:barbershpo_flutter/features/Reservation_client/views/reservation_page.dart';
import 'package:flutter/material.dart';

import '../../support.dart';


class ReservationHomeScreen extends StatefulWidget {
  static final List<Map<String,String>> reservationListe = [];


  @override
  _ReservationHomeScreenState createState() => _ReservationHomeScreenState();
}

class _ReservationHomeScreenState extends State<ReservationHomeScreen> {

  int _selectedIndex = 0;
  final List<Widget> _pages = [
    ReservationPage(),  // Nouvelle page principale
    ReservationListePage(ReservationHomeScreen.reservationListe),
    SupportClientPage(),
  ];



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Réserver'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Mes Réservations'),
          BottomNavigationBarItem(icon: Icon(Icons.support), label: 'Support'),
        ],
      ),
    );
  }
}