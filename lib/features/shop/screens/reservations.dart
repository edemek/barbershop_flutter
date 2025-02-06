import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/*
class BookingScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<BookingScreen> {
  List<Map<String, dynamic>> reservations = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("BarberShop", style: TextStyle(color: Colors.blue)),
          backgroundColor: Colors.white,
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "Salons"),
              Tab(text: "Mes Réservations"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SalonLitScreen(onReserve: (reservation) {
              setState(() {
                reservations.add(reservation);
              });
            }),
            ReservationScreen(reservations: reservations),
          ],
        ),
      ),
    );
  }
}

class SalonListScreen extends StatelessWidget {
  final Function(Map<String, dynamic>) onReserve;
  final List<Map<String, dynamic>> salons = [
    {
      'name': 'Salon Prestige',
      'image1': 'assets/images/photo_salon/s1_1.jpg',
      'image2': 'assets/images/photo_salon/s1_2.jpg',
      'location': 'Lomé, Togo',
      'description': 'Un salon haut de gamme offrant une coupe moderne.',
      'phone': '+228 90 12 34 56'
    },
    {
      'name': 'Barber King',
      'image1': 'assets/images/photo_salon/s2_1.jpg',
      'image2': 'assets/images/photo_salon/s2_2.jpg',
      'location': 'Kara, Togo',
      'description': 'Un barber shop authentique avec des professionnels.',
      'phone': '+228 91 23 45 67'
    }
  ];

  SalonLitScreen({required this.onReserve});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: salons.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SalonDetailScreen(
                  salon: salons[index],
                  onReserve: onReserve,
                ),
              ),
            );
          },
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(salons[index]['name'],
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 4),
                  Text(salons[index]['location'],
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SalonDetailScreen extends StatefulWidget {
  final Map<String, dynamic> salon;
  final Function(Map<String, dynamic>) onReserve;

  SalonDetailScreen({required this.salon, required this.onReserve});

  @override
  _SalonDetailScreenState createState() => _SalonDetailScreenState();
}

class _SalonDetailScreenState extends State<SalonDetailScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.salon['name'])),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Image.asset(widget.salon['image1'], height: 100)),
                SizedBox(width: 8),
                Expanded(child: Image.asset(widget.salon['image2'], height: 100)),
              ],
            ),
            SizedBox(height: 16),
            Text("Adresse : ${widget.salon['location']}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("Description : ${widget.salon['description']}"),
            SizedBox(height: 4),
            Text("Téléphone : ${widget.salon['phone']}",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _pickDate,
                  child: Text(selectedDate == null
                      ? "Choisir une date"
                      : DateFormat.yMMMd().format(selectedDate!)),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _pickTime,
                  child: Text(selectedTime == null
                      ? "Choisir une heure"
                      : selectedTime!.format(context)),
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _reserve,
                child: Text("Réserver"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  void _reserve() {
    if (selectedDate != null && selectedTime != null) {
      widget.onReserve({
        'salon': widget.salon['name'],
        'date': DateFormat.yMMMd().format(selectedDate!),
        'time': selectedTime!.format(context),
      });
      Navigator.pop(context);
    }
  }
}

class ReservationScreen extends StatelessWidget {
  final List<Map<String, dynamic>> reservations;

  ReservationScreen({required this.reservations});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: reservations
          .map((res) => ListTile(
        title: Text(res['salon']),
        subtitle: Text("${res['date']} à ${res['time']}"),
      ))
          .toList(),
    );
  }
}
*/