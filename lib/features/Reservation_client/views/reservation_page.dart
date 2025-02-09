import 'package:barbershpo_flutter/features/reservation_client/views/reservation_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/reservation_controller.dart';

class ReservationPage extends GetView<ReservationController> {
  static const Color goldColor = Color(0xFFD4AF37);
  static const Color lightBlack = Color(0xFF333333);
  static const Color offWhite = Color(0xFFF5F5F5);

  // Fonction pour sélectionner une date de réservation
  Future<void> _selectDate(BuildContext context) async {
    final DateTime firstDate = DateTime.now();
    final DateTime lastDate = DateTime(DateTime.now().year + 2);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate.value,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: goldColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: lightBlack,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != controller.selectedDate.value) {
      controller.selectedDate.value = picked;
    }
  }

  // Fonction pour sélectionner une heure de réservation
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: controller.selectedTime.value,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: goldColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: lightBlack,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != controller.selectedTime.value) {
      controller.selectedTime.value = picked;
    }
  }

  // Fonction pour confirmer la réservation
  void _confirmReservation(BuildContext context) {
    if (controller.selectedService.value == null || controller.selectedSalon.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Veuillez sélectionner un service et un salon"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final formattedDate = formatter.format(controller.selectedDate.value);
    final formattedTime = controller.selectedTime.value.format(context);

    // Ajouter la réservation à la liste
    ReservationHomeScreen.reservationListe.add({
      'service': controller.selectedService.value!,
      'salon': controller.selectedSalon.value!,
      'date': formattedDate,
      'heure': formattedTime,
    });

    // Notification de confirmation de réservation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Réservation confirmée ! Un e-mail vous a été envoyé")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Réservation',
          style: TextStyle(color: lightBlack),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Choisissez un salon"),
            _buildDropdown(
              value: controller.selectedSalon.value,
              hint: 'Sélectionnez un salon',
              items: controller.salons,
              onChanged: (String? newValue) {
                controller.selectedSalon.value = newValue!;
              },
            ),
            SizedBox(height: 20),

            _buildSectionTitle("Choisissez un service"),
            _buildDropdown(
              value: controller.selectedService.value,
              hint: 'Sélectionnez un service',
              items: controller.services,
              onChanged: (String? newValue) {
                controller.selectedService.value = newValue!;
              },
            ),
            SizedBox(height: 20),

            _buildSectionTitle("Choisissez une date"),
            _buildDateTimeSelector(
              text: DateFormat('dd MMMM yyyy').format(controller.selectedDate.value),
              icon: Icons.calendar_today,
              onPressed: () => _selectDate(context),
            ),
            SizedBox(height: 20),

            _buildSectionTitle("Choisissez une heure"),
            _buildDateTimeSelector(
              text: controller.selectedTime.value.format(context),
              icon: Icons.access_time,
              onPressed: () => _selectTime(context),
            ),
            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () => _confirmReservation(context),
              child: Text('Confirmer la réservation'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget personnalisé pour les titres de section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: lightBlack,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Widget personnalisé pour les menus déroulants
  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required void Function(String?)? onChanged,
  }) {
    return DropdownButton<String>(
      value: value,
      hint: Text(hint),
      isExpanded: true,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  // Widget personnalisé pour la sélection de date/heure
  Widget _buildDateTimeSelector({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(color: lightBlack),
        ),
        IconButton(
          icon: Icon(icon, color: goldColor),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
