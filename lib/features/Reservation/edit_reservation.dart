import 'package:flutter/material.dart';

class EditReservations extends StatelessWidget {
  final List<Map<String, String>> reservations;
  final List<String> statuses;
  final Function(int, String) updateStatus;

  EditReservations({required this.reservations, required this.statuses, required this.updateStatus});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reservations.length,
      itemBuilder: (context, index) {
        final reservation = reservations[index];
        return Card(
          color: Color(0xFF424242),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Color(0xFFDAA520), width: 2),
          ),
          child: ListTile(
            title: Text("${reservation['client']} - ${reservation['service']}", style: TextStyle(color: Colors.white)),
            subtitle: Text("Date: ${reservation['date']}", style: TextStyle(color: Colors.grey)),
            trailing: DropdownButton<String>(
              dropdownColor: Color(0xFF424242),
              value: reservation['status'],
              items: statuses.sublist(1).map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status, style: TextStyle(color: Color(0xFFDAA520))),
                );
              }).toList(),
              onChanged: (newStatus) {
                updateStatus(index, newStatus!);
              },
            ),
          ),
        );
      },
    );
  }
}
