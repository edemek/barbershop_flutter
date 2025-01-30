import 'package:flutter/material.dart';
import 'edit_reservation.dart';
import 'messaging.dart';

class ReservationDashboard extends StatefulWidget {
  @override
  _ReservationDashboardState createState() => _ReservationDashboardState();
}

class _ReservationDashboardState extends State<ReservationDashboard> {
  int _selectedIndex = 0;
  String selectedStatus = "Tous";
  final List<String> statuses = ["Tous", "Confirmé", "Annulé", "En attente"];
  final List<Map<String, String>> reservations = [
    {"client": "Moustapha", "date": "2025-01-28", "status": "Confirmé", "service": "RastaCoiffure"},
    {"client": "Jonathan", "date": "2025-01-29", "status": "En attente", "service": "Maize"},
    {"client": "Urbain", "date": "2025-02-01", "status": "Annulé", "service": "Tectonique"},
  ];

  void _updateStatus(int index, String newStatus) {
    setState(() {
      reservations[index]['status'] = newStatus;
    });
  }

  List<Widget> _pages() {
    return [
      _buildReservationsList(),
      EditReservations(reservations: reservations, statuses: statuses, updateStatus: _updateStatus),
      MessagingPage(),
    ];
  }

  Widget _buildReservationsList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropdownButton<String>(
            dropdownColor: Color(0xFF424242),
            isExpanded: true,
            value: selectedStatus,
            items: statuses.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status, style: TextStyle(color: Color(0xFFDAA520), fontSize: 16)),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedStatus = value!;
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              final reservation = reservations[index];
              if (selectedStatus != "Tous" && reservation['status'] != selectedStatus) {
                return SizedBox.shrink();
              }
              return Card(
                color: Color(0xFF424242),
                elevation: 6,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Color(0xFFDAA520), width: 2),
                ),
                child: ListTile(
                  leading: Icon(Icons.person, color: Color(0xFFDAA520)),
                  title: Text(
                    "${reservation['client']} - ${reservation['service']}",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Date: ${reservation['date']}", style: TextStyle(color: Colors.grey)),
                  trailing: Chip(
                    label: Text(reservation['status']!, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    backgroundColor: reservation['status'] == "Confirmé"
                        ? Colors.greenAccent
                        : (reservation['status'] == "Annulé" ? Colors.redAccent : Colors.orangeAccent),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF424242),
        title: Text('Tableau de bord des réservations', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: _pages()[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Color(0xFFDAA520),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Liste"),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: "Modifier"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messages"),
        ],
      ),
    );
  }
}
