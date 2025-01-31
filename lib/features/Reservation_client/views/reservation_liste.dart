import 'package:flutter/material.dart';
import 'reservation_page.dart';
class ReservationListePage extends StatelessWidget {
  final List<Map<String, String>> reservationListe;

  ReservationListePage(this.reservationListe);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liste des Réservations')),
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
