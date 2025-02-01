import 'package:flutter/material.dart';

class ReservationListePage extends StatelessWidget {
  final List<Map<String, String>> reservationListe; // Liste des réservations à afficher

  ReservationListePage(this.reservationListe); // Constructeur pour recevoir la liste

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mes Réservations')),
      body: ListView.builder(
        itemCount: reservationListe.length,
        itemBuilder: (context, index) {
          final reservation = reservationListe[index];
          return Card(
            child: ListTile(
              title: Text(reservation['service']!),
              subtitle: Text('${reservation['salon']} - ${reservation['date']} à ${reservation['heure']}'),
            ),
          );
        },
      ),
    );
  }
}
